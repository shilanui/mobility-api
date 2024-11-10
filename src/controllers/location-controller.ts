import { Request, Response, NextFunction } from "express";
import prisma from "../models/prisma";

export const getProvince = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  try {
    let province = await prisma.province.findMany();

    res.status(200).json({ province });
  } catch (err) {
    next(err);
  }
};

export const getAmphure = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  try {
    const { params } = req;
    const provinceId: any = params?.provinceId;

    let amphure = await prisma.amphure.findMany({
      where: {
        province_id: +provinceId,
      },
    });

    res.status(200).json({ amphure });
  } catch (err) {
    next(err);
  }
};

export const getSubDistrict = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  try {
    const { params } = req;
    const amphureId: any = params?.amphureId;

    let subDistrict = await prisma.sub_District.findMany({
      where: {
        amphure_id: +amphureId,
      },
    });

    res.status(200).json({ subDistrict });
  } catch (err) {
    next(err);
  }
};
