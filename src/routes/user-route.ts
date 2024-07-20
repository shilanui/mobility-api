// import express, { Router } from "express";
import * as express from "express";
import { getAll, getUserById } from "../controllers/user-controller";
// const authenticateMiddleware = require("../middlewares/authticate");
const router = express.Router();

router.get("/", getAll);
router.get("/:id", getUserById);

export { router as default };
