import { Request, Response, NextFunction } from "express";
import prisma from "../models/prisma";
import { uploadImage } from "../utils/cloudinary-service";
import moment from "moment";

export const getAll = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  try {
    let propertyPost = await prisma.property_Post.findMany();

    res.status(200).json({ propertyPost });
  } catch (err) {
    next(err);
  }
};

export const getPropertyPostByStatus = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  try {
    const { params } = req;
    const status: any = params?.status;

    let propertyPost = await prisma.property_Post.findMany({
      where: {
        status_id: +status,
      },
    });

    res.status(200).json({ propertyPost });
  } catch (err) {
    next(err);
  }
};

export const getPropertyPostById = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  try {
    const { params } = req;
    const id: any = params?.id;

    let propertyPost = await prisma.property_Post.findFirst({
      where: {
        id: +id,
      },
    });

    res.status(200).json({ propertyPost });
  } catch (err) {
    next(err);
  }
};

export const getPropertyPostByUserId = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  try {
    const { params } = req;
    const userId: any = params?.userId;

    let propertyPost = await prisma.property_Post.findMany({
      where: {
        user_id: +userId,
      },
    });

    res.status(200).json({ propertyPost });
  } catch (err) {
    next(err);
  }
};

export const addPropertyPost = async (
  req: any,
  res: Response,
  next: NextFunction
) => {
  try {
    const { body } = req;

    let propertyPost = await prisma.property_Post.create({
      data: {
        user_id: body?.userId,
        title_deed_id: null,
        status_id: 1,
        unit_id: null,
        geographies_id: null,
        province_id: null,
        amphure_id: null,
        sub_district_id: null,
        property_type_id: null,
        property_name: body?.name,
        description: body?.description,
        image: body?.imageUrl,
        price: +body?.price,
        latitude: +body?.latitude,
        longitude: +body?.longitude,
        land_area_rai: null,
        land_area_ngan: null,
        land_area_square_wa: null,
        usable_size_square_m: null,
        bedroom_count: null,
        bathroom_count: null,
        kitchen_count: null,
        floors_count: null,
        view_count: null,
        updated_at: moment().format(),
      },
    });

    res.status(200).json({ data: propertyPost });
  } catch (err) {
    next(err);
  }
};

export const searchPropertyPostByName = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  try {
    const { body } = req;
    const name: string = body?.name;

    let propertyPost = await prisma.property_Post.findMany({
      where: {
        property_name: {
          contains: name,
        },
      },
    });

    res.status(200).json({ propertyPost });
  } catch (err) {
    next(err);
  }
};
