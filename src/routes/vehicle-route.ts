import express, { Router } from "express";
import {
  getAll,
  getEventByVehicleId,
  getVehicleScoreById,
  getVehicleScores,
} from "../controllers/vehicle-controller";
const router: Router = express.Router();

router.get("/", getAll);
router.get("/scores", getVehicleScores);
router.get("/:vehicle_id/score", getVehicleScoreById);
router.get("/:vehicle_id/events", getEventByVehicleId);

export default router;
