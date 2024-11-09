// const prisma = require("../models/prisma");
import { Request, Response, NextFunction } from "express";
import prisma from "../models/prisma";

export const login = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  try {
    const { body } = req;

    let user = await prisma.user.findFirst({
      where: {
        email: body?.email,
        password: body?.password,
      },
    });

    if (user) {
      res.status(200).json({ user });
    } else {
      res.status(400).json({ message: "User not found" });
    }
  } catch (err) {
    next(err);
  }
};
