import { Request, Response, NextFunction } from "express";
import prisma from "../models/prisma";

export const getEventTypes = async (
  req: Request,
  res: Response,
  next: NextFunction,
) => {
  try {
    const data = await prisma.event.findMany();

    if (!data.length) {
      return res.status(404).json({ message: "No event types found" });
    }

    return res.status(200).json({ data });
  } catch (err) {
    next(err);
  }
};

export const getUnsafeEvents = async (
  req: Request,
  res: Response,
  next: NextFunction,
) => {
  try {
    const { vehicle_id, severity } = req.query;

    const where: any = {};

    if (vehicle_id !== undefined) {
      const vehicleId = Number(vehicle_id);

      if (isNaN(vehicleId) || vehicleId <= 0) {
        return res.status(400).json({ message: "Invalid vehicle_id" });
      }

      where.vehicle_id = vehicleId;
    }

    if (severity !== undefined) {
      if (!["LOW", "MEDIUM", "HIGH"].includes(String(severity))) {
        return res.status(400).json({ message: "Invalid severity" });
      }

      where.severity = severity;
    }

    const data = await prisma.unsafe_event.findMany({
      where,
      include: {
        driver: true,
        vehicle: true,
        event: true,
        vehicle_telemetry: true,
      },
      orderBy: {
        timestamp: "desc",
      },
    });

    if (!data.length) {
      return res.status(404).json({ message: "No unsafe events found" });
    }

    return res.status(200).json({ data });
  } catch (err) {
    next(err);
  }
};
