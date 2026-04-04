import { PrismaClient } from "@prisma/client";
import fs from "fs";
import path from "path";

const prisma = new PrismaClient();

const SERVERITY = {
  LOW: "LOW",
  MEDIUM: "MEDIUM",
  HIGH: "HIGH",
};

async function seedVerhicleAndTelemetry() {
  const filePathVehicle = path.join(
    __dirname,
    "data",
    "vehicle_telemetry-2.json",
  );
  const filePathEvent = path.join(__dirname, "data", "toyota_events.json");
  const filePathSignal = path.join(
    __dirname,
    "data",
    "toyota_can_signals.json",
  );
  const rawVehicle = fs.readFileSync(filePathVehicle, "utf-8");
  const rawEvent = fs.readFileSync(filePathEvent, "utf-8");
  const rawSignal = fs.readFileSync(filePathSignal, "utf-8");

  const recordsVehicle = JSON.parse(rawVehicle);
  const recordsEvent = JSON.parse(rawEvent);
  const recordsSignal = JSON.parse(rawSignal);

  for (const item of recordsVehicle) {
    const vehicle = await prisma.vehicle.upsert({
      where: {
        vehicle_name: item.vehicle_id,
      },
      update: {},
      create: {
        vehicle_name: item.vehicle_id,
      },
    });

    const driver = await prisma.drivers.upsert({
      where: {
        driver_name: item.driver_name,
      },
      update: {},
      create: {
        driver_name: item.driver_name,
      },
    });

    await prisma.driver_vehicle.upsert({
      where: {
        vehicle_id_driver_id: {
          vehicle_id: vehicle.id,
          driver_id: driver.id,
        },
      },
      update: {},
      create: {
        vehicle_id: vehicle.id,
        driver_id: driver.id,
      },
    });
  }
  const eventData = [
    {
      event_type: 30,
      event_name: "Heartbeat",
    },
    {
      event_type: 33,
      event_name: "Engine ON",
    },
    {
      event_type: 34,
      event_name: "Engine OFF",
    },
    { event_type: 35, event_name: "Speeding" },
    { event_type: 36, event_name: "Harsh Braking" },
    { event_type: 37, event_name: "Harsh Acceleration" },
  ];

  await prisma.event.createMany({
    data: eventData,
  });

  const vehicleList = await prisma.vehicle.findMany();
  const driverList = await prisma.drivers.findMany();
  const eventList = await prisma.event.findMany();

  const vehicleMap = Object.fromEntries(
    vehicleList.map((v) => [v.vehicle_name, v.id]),
  );
  const driverMap = Object.fromEntries(
    driverList.map((v) => [v.driver_name, v.id]),
  );
  const eventMap = Object.fromEntries(
    eventList.map((v) => [v.event_type, v.id]),
  );

  const vehicleTelemetryData = recordsVehicle.map((item: any) => ({
    vehicle_id: vehicleMap[item.vehicle_id],
    driver_id: driverMap[item.driver_name],
    source: item.source,
    timestamp: new Date(item.timestamp),
    lat: item.lat,
    long: item.lon,
    speed_kmh: item.speed_kmh,
    heading_deg: item.heading_deg,
    engine_on: item.engine_on,
    odometer_km: item.odometer_km,
  }));

  const vehicleEventData = recordsEvent.map((item: any) => ({
    vehicle_id: vehicleMap[item.vehicle_id],
    event_id: eventMap[item.event_type],
    timestamp: new Date(item.timestamp),
    lat: item.lat,
    long: item.lon,
    speed_kmh: item.speed_kmh,
    fuel_input_liters: item.fuel_input_liters,
    total_distance_km: item.total_distance_km,
    battery_voltage: item.battery_voltage,
  }));

  const signalData = recordsSignal.map((item: any) => ({
    vehicle_id: vehicleMap[item.vehicle_id],
    timestamp: new Date(item.timestamp),
    signal_name: item.signal_name,
    signal_value: item.signal_value,
    signal_unit: item.signal_unit,
  }));

  await prisma.vehicle_telemetry.createMany({
    data: vehicleTelemetryData,
  });

  await prisma.vehicle_event.createMany({
    data: vehicleEventData,
  });

  await prisma.can_signal.createMany({
    data: signalData,
  });
}

async function calculateUnsafeEvent() {
  const vehicleTelemetry = await prisma.vehicle_telemetry.findMany({
    orderBy: { timestamp: "asc" },
  });

  const SPEED_LIMIT = 120;
  const BRAKE_THRESHOLD = 10;
  const ACCEL_THRESHOLD = 10;

  const eventTypes = await prisma.event.findMany();

  const mapType: Record<number, number> = Object.fromEntries(
    eventTypes.map((e) => [e.event_type, e.id]),
  );

  const unsafeEvents: any[] = [];

  const grouped = Object.values(
    vehicleTelemetry.reduce((acc: Record<number, any[]>, item) => {
      if (!acc[item.vehicle_id]) acc[item.vehicle_id] = [];
      acc[item.vehicle_id].push(item);
      return acc;
    }, {}),
  );

  for (const records of grouped) {
    for (let i = 0; i < records.length; i++) {
      const current = records[i];
      const previous = records[i - 1];

      // Heartbeat
      unsafeEvents.push({
        vehicle_id: current.vehicle_id,
        driver_id: current.driver_id,
        event_id: mapType[30],
        severity: SERVERITY.LOW,
        timestamp: current.timestamp,
        telemetry_id: current.id,
      });

      if (!previous) continue;

      const dt =
        (new Date(current.timestamp).getTime() -
          new Date(previous.timestamp).getTime()) /
        1000;

      if (dt <= 0 || dt > 60) continue;

      const previousSpeed = previous.speed_kmh ?? 0;
      const currentSpeed = current.speed_kmh ?? 0;

      // Engine ON
      if (!previous.engine_on && current.engine_on) {
        unsafeEvents.push({
          vehicle_id: current.vehicle_id,
          driver_id: current.driver_id,
          event_id: mapType[33],
          severity: SERVERITY.LOW,
          timestamp: current.timestamp,
          telemetry_id: current.id,
        });
      }

      // Engine OFF
      if (previous.engine_on && !current.engine_on) {
        unsafeEvents.push({
          vehicle_id: current.vehicle_id,
          driver_id: current.driver_id,
          event_id: mapType[34],
          severity: SERVERITY.LOW,
          timestamp: current.timestamp,
          telemetry_id: current.id,
        });
      }

      // Speeding
      if (currentSpeed > SPEED_LIMIT) {
        unsafeEvents.push({
          vehicle_id: current.vehicle_id,
          driver_id: current.driver_id,
          event_id: mapType[35],
          severity:
            currentSpeed > 140
              ? SERVERITY.HIGH
              : currentSpeed > 120
                ? SERVERITY.MEDIUM
                : SERVERITY.LOW,
          value: currentSpeed,
          threshold: SPEED_LIMIT,
          timestamp: current.timestamp,
          telemetry_id: current.id,
        });
      }

      // Harsh Braking
      const harshBrake = (previousSpeed - currentSpeed) / dt;

      if (harshBrake > BRAKE_THRESHOLD) {
        unsafeEvents.push({
          vehicle_id: current.vehicle_id,
          driver_id: current.driver_id,
          event_id: mapType[36],
          severity: harshBrake > 40 ? SERVERITY.HIGH : SERVERITY.MEDIUM,
          value: harshBrake,
          threshold: BRAKE_THRESHOLD,
          timestamp: current.timestamp,
          telemetry_id: current.id,
        });
      }

      // Harsh Acceleration
      const acceleration = (currentSpeed - previousSpeed) / dt;

      if (acceleration > ACCEL_THRESHOLD) {
        unsafeEvents.push({
          vehicle_id: current.vehicle_id,
          driver_id: current.driver_id,
          event_id: mapType[37],
          severity: acceleration > 20 ? SERVERITY.HIGH : SERVERITY.MEDIUM,
          value: acceleration,
          threshold: ACCEL_THRESHOLD,
          timestamp: current.timestamp,
          telemetry_id: current.id,
        });
      }
    }
  }

  if (unsafeEvents.length > 0) {
    await prisma.unsafe_event.createMany({
      data: unsafeEvents,
      skipDuplicates: true,
    });
  }
}

async function clearDatabase() {
  await prisma.$transaction([
    prisma.unsafe_event.deleteMany(),
    prisma.vehicle_event.deleteMany(),
    prisma.can_signal.deleteMany(),
    prisma.vehicle_telemetry.deleteMany(),
    prisma.driver_score.deleteMany(),
    prisma.driver_vehicle.deleteMany(),
    prisma.drivers.deleteMany(),
    prisma.vehicle.deleteMany(),
    prisma.event.deleteMany(),
  ]);
}

async function main() {
  console.log("Start seed");

  //   await clearDatabase();
  await seedVerhicleAndTelemetry();
  //   await calculateUnsafeEvent();

  console.log("Done seed");
}

main()
  .catch((e) => {
    console.error(e);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });
