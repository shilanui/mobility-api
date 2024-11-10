import express, { Router } from "express";
import {
  getProvince,
  getAmphure,
  getSubDistrict,
} from "../controllers/location-controller";
const router: Router = express.Router();

router.get("/province", getProvince);
router.get("/amphure/:provinceId", getAmphure);
router.get("/subDistrict/:amphureId", getSubDistrict);

export default router;
