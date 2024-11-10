import express, { Router } from "express";
import {
  addPropertyPost,
  getAll,
  getPropertyPostByStatus,
  getPropertyPostByUserId,
  getPropertyPostById,
  searchPropertyPostByName,
} from "../controllers/property-controller";
const router: Router = express.Router();

router.get("/getAll", getAll);
router.get("/:id", getPropertyPostById);
router.get("/status/:status", getPropertyPostByStatus);
router.get("/user/:userId", getPropertyPostByUserId);
router.post("/add", addPropertyPost);
router.post("/name", searchPropertyPostByName);

export default router;
