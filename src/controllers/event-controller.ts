import { Request, Response, NextFunction } from "express";
import prisma from "../models/prisma";

export const getEventTypes = async (
  req: Request,
  res: Response,
  next: NextFunction,
) => {
  try {
    const data = await prisma.event.findMany();

    res.status(201).json({ data });
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
    const data = await prisma.unsafe_event.findMany({
      include: {
        driver: true,
        vehicle: true,
        event: true,
        vehicle_telemetry: true,
      },
    });

    res.status(201).json({ data });
  } catch (err) {
    next(err);
  }
};
