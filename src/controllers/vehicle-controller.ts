import { Request, Response, NextFunction } from "express";
import prisma from "../models/prisma";
import { PENALTY, Severity } from "../constant";

export const getAll = async (
  req: Request,
  res: Response,
  next: NextFunction,
) => {
  try {
    const data = await prisma.vehicle.findMany();

    res.status(201).json({ data });
  } catch (err) {
    next(err);
  }
};

export const getScoreByVehicleId = async (
  req: Request,
  res: Response,
  next: NextFunction,
) => {
  try {
    const data = await prisma.vehicle.findMany();

    res.status(201).json({ data });
  } catch (err) {
    next(err);
  }
};

export const getEventByVehicleId = async (
  req: Request,
  res: Response,
  next: NextFunction,
) => {
  try {
    const { vehicle_id } = req.params;
    const { severity } = req.query;

    const where: any = {
      vehicle_id: Number(vehicle_id),
    };

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

    res.json({
      data: data.map((e) => ({
        event_type: e.event.event_name,
        severity: e.severity,
        value: e.value,
        threshold: e.threshold,
        timestamp: e.timestamp,
        events: e.event,
      })),
    });
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: "Internal error" });
  }
};

export const getVehicleScores = async (req: Request, res: Response) => {
  try {
    const vehicles = await prisma.vehicle.findMany({
      include: {
        driver_vehicle: {
          include: {
            driver: true,
            vehicle: true,
          },
        },
      },
    });

    const results = await Promise.all(
      vehicles.map(async (v) => {
        const score = await calculateDriverScore(v.id);

        return {
          vehicle_id: v.id,
          vehicle_name: v.vehicle_name,
          driver: v.driver_vehicle
            ?.filter((dv) => dv.vehicle_id === v.id)
            .map((dv) => dv.driver),
          overall_score: score.finalScore,
          risk_class: score.riskClass,
          component_scores: score.breakdown,
        };
      }),
    );

    res.json({
      data: results,
    });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: "Internal server error" });
  }
};

export const getVehicleScoreById = async (req: Request, res: Response) => {
  try {
    const vehicleId = Number(req.params.vehicle_id);

    const result = await calculateDriverScore(vehicleId);

    res.json({
      vehicle_id: vehicleId,
      overall_score: result.finalScore,
      risk_class: result.riskClass,
      component_scores: result.breakdown,
    });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: "Internal server error" });
  }
};

async function calculateDriverScore(vehicleId: number) {
  const events = await prisma.unsafe_event.findMany({
    where: {
      vehicle_id: vehicleId,
    },
    include: {
      event: true,
    },
  });

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
      speeding: 100 - speedingPenalty,
      braking: 100 - brakingPenalty,
      acceleration: 100 - accelPenalty,
    },
  };
}
