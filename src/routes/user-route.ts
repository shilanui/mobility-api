import express, { Router } from "express";
// const express = require("express");
import { getAll, getUserById } from "../controllers/user-controller";
// const userController = require("../controllers/user-controller");
// const authenticateMiddleware = require("../middlewares/authticate");
const router: Router = express.Router();

router.get("/", getAll);
router.get("/:id", getUserById);

export default router;
