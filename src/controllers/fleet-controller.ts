import { Request, Response, NextFunction } from "express";
import prisma from "../models/prisma";

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
    const { params } = req;

    const vehicleId = +params.vehicle_id;
    const data = await prisma.unsafe_event.findMany({
      where: { vehicle_id: vehicleId },
      include: {
        event: true,
      },
    });

    res.status(201).json({ data });
  } catch (err) {
    next(err);
  }
};
