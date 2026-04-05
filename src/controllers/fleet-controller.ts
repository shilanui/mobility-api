import { Request, Response, NextFunction } from "express";
import prisma from "../models/prisma";
import { isValidId } from "../utils/helper";

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

export const getScoreByVehicleId = async (
  req: Request,
  res: Response,
  next: NextFunction,
) => {
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

    // TODO: in the future
    return res.status(200).json({
      vehicle_id: vehicleId,
      score: 100,
    });
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

    const data = await prisma.unsafe_event.findMany({
      where: { vehicle_id: vehicleId },
      include: {
        event: true,
      },
    });

    if (!data.length) {
      return res.status(404).json({ message: "No events found" });
    }

    return res.status(200).json({ data });
  } catch (err) {
    next(err);
  }
};
