// const prisma = require("../models/prisma");
// const fs = require("fs/promises");
import fs from "fs/promises";
import { Request, Response, NextFunction } from "express";
import prisma from "../models/prisma";
import { uploadImage } from "../utils/cloudinary-service";

export const upload = async (req: any, res: Response, next: NextFunction) => {
  try {
    const { message } = req.body;
    // if ((!message || !message.trim()) && !req.file) {
    //   return next(createError("message or image is required", 400));
    // }

    console.log("req.file =", req.file);

    let image = null;
    if (req?.file) {
      image = await uploadImage(req.file.path);
    }

    console.log("image =", image);

    res.status(201).json({ message: "upload image complete", imageUrl: image });
  } catch (err) {
    next(err);
  } finally {
    if (req.file) {
      fs.unlink(req.file.path);
    }
  }
};
