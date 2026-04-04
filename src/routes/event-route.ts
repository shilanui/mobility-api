import express, { Router } from "express";
import {
  getEventTypes,
  getUnsafeEvents,
} from "../controllers/event-controller";
const router: Router = express.Router();

router.get("/types", getEventTypes);
router.get("/unsafe", getUnsafeEvents);

export default router;
