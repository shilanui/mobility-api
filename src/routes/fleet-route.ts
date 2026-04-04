import express, { Router } from "express";
import { getAll } from "../controllers/fleet-controller";
const router: Router = express.Router();

router.get("/summary", getAll);

export default router;
