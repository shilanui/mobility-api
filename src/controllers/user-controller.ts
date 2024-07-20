import { Request, Response, NextFunction } from "express";
import prisma from "../models/prisma";

export const getAll = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  try {
    console.log("getAll");
    // const { params } = req;
    // console.log("req =", req.params.id);

    // let user;

    // let user = await prisma.user.findMany();

    // user = await prisma.User.findFirst({
    //   where: {
    //     id: +params.id,
    //   },
    // });

    res.status(201).json({ user: "test" });
    // res.status(201).json({ user });
  } catch (err) {
    next(err);
  }
};

export const getUserById = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  try {
    console.log("getUserById");
    // const { params } = req;
    // console.log("req =", req.params.id);

    // let user;

    let user = await prisma.user.findMany();

    // user = await prisma.User.findFirst({
    //   where: {
    //     id: +params.id,
    //   },
    // });

    res.status(201).json({ user });
    // res.status(201).json({ user });
  } catch (err) {
    next(err);
  }
};
