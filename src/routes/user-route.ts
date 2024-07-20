import express from "express";
import { getAll, getUserById } from "../controllers";
const authenticateMiddleware = require("../middlewares/authticate");
const router = express.Router();

router.get("/", getAll);
router.get("/:id", authenticateMiddleware, getUserById);

export { router as default };
