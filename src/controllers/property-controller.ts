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

    console.log("getPropertyPostByStatus propertyPost = ", propertyPost);

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
    console.log("req.file =", req?.file);

    let image = null;
    if (req.file) {
      // image = await uploadImage(req.file.path);
    }

    let propertyPost = await prisma.property_Post.create({
      data: {
        user_id: null,
        title_deed_id: null,
        status_id: null,
        unit_id: null,
        geographies_id: null,
        province_id: null,
        amphure_id: null,
        sub_district_id: null,
        property_type_id: null,
        property_name: body?.name,
        description: body?.description,
        image: null,
        // image,
        price: 1000,
        latitude: null,
        longitude: null,
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
