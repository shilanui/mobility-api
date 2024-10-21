import { Request, Response, NextFunction } from 'express';
import prisma from '../models/prisma';

export const getAll = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  try {
    console.log('getAll');
    // const { params } = req;
    // console.log("req =", req.params.id);

    // let user;

    // let user = await prisma.user.findMany();

    // user = await prisma.User.findFirst({
    //   where: {
    //     id: +params.id,
    //   },
    // });
    let role = await prisma.role.findMany();

    res.status(201).json({ role });
    // res.status(201).json({ user });
  } catch (err) {
    next(err);
  }
};

export const getRoleById = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  try {
    console.log('req =', req.params);
    const id = req?.params?.id;
    // const { params } = req;
    // console.log("req =", req.params.id);

    // let user;

    let role = await prisma.role.findMany({
      where: {
        id: Number(id),
      },
    });

    // role = await prisma.User.findFirst({
    //   where: {
    //     id: +params.id,
    //   },
    // });

    res.status(201).json({ role });
  } catch (err) {
    next(err);
  }
};
