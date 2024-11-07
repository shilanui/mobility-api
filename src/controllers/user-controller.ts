// const prisma = require("../models/prisma");
import { Request, Response, NextFunction } from "express";
import prisma from "../models/prisma";
import moment from "moment";

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

export const getUserById = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  try {
    const { params } = req;

    let user = await prisma.user.findFirst({
      where: {
        id: +params?.id,
      },
    });

    res.status(200).json({ user });
  } catch (err) {
    next(err);
  }
};

export const createUser = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  try {
    const { body } = req;

    let user = await prisma.user.create({
      data: {
        // role_id: body?.role_id ?? null,
        package_id: body?.package_id ?? null,
        status_id: body?.status_id ?? null,
        tax_id_no: body?.tax_id_no ?? null,
        username: body?.username ?? null,
        password: body?.password ?? null,
        first_name: body?.first_name ?? null,
        last_name: body?.last_name ?? null,
        birth_date: body?.birth_date ? moment(body?.birth_date).format() : "", //'2024-10-10T00:00:00.000Z'
        phone_number: body?.phone_number ?? null,
        email: body?.email ?? null,
      },
    });

    res.status(200).json({ user });
  } catch (err) {
    next(err);
  }
};
export const updateUser = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  try {
    const { body, params } = req;

    const agency_id = body?.agency_id;
    const userId = params?.id;

    const updateUser = await prisma.user.update({
      where: {
        id: +userId,
      },
      data: {
        // agency_id: body?.agency_id ?? null,
        // {...(agency_id ? body?.agency_id : null)}
      },
    });

    res.status(200).json({ user: updateUser });
  } catch (err) {
    next(err);
  }
};
