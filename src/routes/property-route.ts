import express, { Router } from "express";
import {
  addPropertyPost,
  getAll,
  getPropertyPostByStatus,
  getPropertyPostByUserId,
} from "../controllers/property-controller";
const router: Router = express.Router();

router.get("/getAll", getAll);
router.get("/get/status/:status", getPropertyPostByStatus);
router.get("/get/user/:userId", getPropertyPostByUserId);
router.post("/add", addPropertyPost);

export default router;
