import { Request, Response, NextFunction } from "express";
import prisma from "../models/prisma";
import { PENALTY, Severity } from "../constant";
import { isValidId, isValidSeverity } from "../utils/helper";

export const getAll = async (
  req: Request,
  res: Response,
  next: NextFunction,
) => {
  try {
    const data = await prisma.vehicle.findMany();

    return res.status(200).json({ data });
  } catch (err) {
    next(err);
  }
};

export const getEventByVehicleId = async (req: Request, res: Response) => {
  try {
    const { vehicle_id } = req.params;
    const { severity } = req.query;

    if (!isValidId(vehicle_id)) {
      return res.status(400).json({ message: "Invalid vehicle_id" });
    }

    const vehicleId = Number(vehicle_id);

    const vehicle = await prisma.vehicle.findUnique({
      where: { id: vehicleId },
    });

    if (!vehicle) {
      return res.status(404).json({ message: "Vehicle not found" });
    }

    if (severity && !isValidSeverity(severity)) {
      return res.status(400).json({ message: "Invalid severity value" });
    }

    const where: any = { vehicle_id: vehicleId };

    if (severity) {
      where.severity = severity;
    }

    const data = await prisma.unsafe_event.findMany({
      where,
      include: {
        event: true,
        vehicle: true,
        driver: true,
        vehicle_telemetry: true,
      },
      orderBy: {
        timestamp: "desc",
      },
    });

    if (!data.length) {
      return res.status(404).json({ message: "No events found" });
    }

    return res.status(200).json({
      data: data.map((e) => ({
        event_type: e.event.event_name,
        severity: e.severity,
        value: e.value,
        threshold: e.threshold,
        timestamp: e.timestamp,
      })),
    });
  } catch (err) {
    console.error(err);
    return res.status(500).json({ message: "Internal server error" });
  }
};

export const getVehicleScores = async (req: Request, res: Response) => {
  try {
    const vehicles = await prisma.vehicle.findMany({
      include: {
        driver_vehicle: {
          include: {
            driver: true,
          },
        },
      },
    });

    if (!vehicles.length) {
      return res.status(404).json({ message: "No vehicles found" });
    }

    const results = await Promise.all(
      vehicles.map(async (v) => {
        const score = await calculateDriverScore(v.id);

        return {
          vehicle_id: v.id,
          vehicle_name: v.vehicle_name,
          driver: v.driver_vehicle.map((dv) => dv.driver),
          overall_score: score.finalScore,
          risk_class: score.riskClass,
          component_scores: score.breakdown,
        };
      }),
    );

    return res.status(200).json({ data: results });
  } catch (error) {
    console.error(error);
    return res.status(500).json({ message: "Internal server error" });
  }
};

// ------------------- SCORE BY ID -------------------
export const getVehicleScoreById = async (req: Request, res: Response) => {
  try {
    const { vehicle_id } = req.params;

    if (!isValidId(vehicle_id)) {
      return res.status(400).json({ message: "Invalid vehicle_id" });
    }

    const vehicleId = Number(vehicle_id);

    const vehicle = await prisma.vehicle.findUnique({
      where: { id: vehicleId },
    });

    if (!vehicle) {
      return res.status(404).json({ message: "Vehicle not found" });
    }

    const result = await calculateDriverScore(vehicleId);

    return res.status(200).json({
      vehicle_id: vehicleId,
      overall_score: result.finalScore,
      risk_class: result.riskClass,
      component_scores: result.breakdown,
    });
  } catch (error) {
    console.error(error);
    return res.status(500).json({ message: "Internal server error" });
  }
};

async function calculateDriverScore(vehicleId: number) {
  const events = await prisma.unsafe_event.findMany({
    where: { vehicle_id: vehicleId },
    include: { event: true },
  });

  if (!events.length) {
    return {
      finalScore: 100,
      riskClass: "A",
      breakdown: {
        speeding: 100,
        braking: 100,
        acceleration: 100,
      },
    };
  }

  let speedingPenalty = 0;
  let brakingPenalty = 0;
  let accelPenalty = 0;

  for (const e of events) {
    const severity: Severity = e.severity;

    if (e.event.event_type === 35) {
      speedingPenalty += PENALTY.SPEEDING[severity] ?? 0;
    }

    if (e.event.event_type === 36) {
      brakingPenalty += PENALTY.BRAKING[severity] ?? 0;
    }

    if (e.event.event_type === 37) {
      accelPenalty += PENALTY.ACCEL[severity] ?? 0;
    }
  }

  const totalPenalty = speedingPenalty + brakingPenalty + accelPenalty;
  const finalScore = Math.max(0, 100 - totalPenalty);

  const riskClass =
    finalScore >= 90
      ? "A"
      : finalScore >= 75
        ? "B"
        : finalScore >= 60
          ? "C"
          : "D";

  return {
    finalScore,
    riskClass,
    breakdown: {
      speeding: Math.max(0, 100 - speedingPenalty),
      braking: Math.max(0, 100 - brakingPenalty),
      acceleration: Math.max(0, 100 - accelPenalty),
    },
  };
}
