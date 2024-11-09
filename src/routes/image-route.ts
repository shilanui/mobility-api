import express, { Router } from "express";
// const express = require("express");
import { upload } from "../controllers/image-controller";
import uploadMiddleware from "../middlewares/upload";
const router: Router = express.Router();

router.post("/upload", uploadMiddleware.single("image"), upload);

export default router;
