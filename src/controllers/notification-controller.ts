import { Request, Response, NextFunction } from 'express';
import prisma from '../models/prisma';

export const getAll = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  try {
    let role = await prisma.role.findMany();

    res.status(201).json({ role });
  } catch (err) {
    next(err);
  }
};

export const getNotiByAgentId = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  try {
    console.log('req =', req.params);
    const id = req?.params?.id;

    let role = await prisma.notification.findFirst({
      where: {
        id: +id,
      },
    });

    res.status(201).json({ role });
  } catch (err) {
    next(err);
  }
};

export const createNotification = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  try {
    console.log('req =', req.params);
    const { body } = req;
    const id = req?.params?.id;

    let noti = await prisma.notification.create({
      data: { ...body },
    });

    res.status(201).json({ noti });
  } catch (err) {
    next(err);
  }
};
