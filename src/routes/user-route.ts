import express, { Router } from "express";
import { getAll, getUserById } from "../controllers";
const authenticateMiddleware = require("../middlewares/authticate");
const router: Router = express.Router();

router.use("/", getAll);
router.use("/:id", authenticateMiddleware, getUserById);

export { router as default };
