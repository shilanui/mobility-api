import express, { Router } from "express";
// const express = require("express");
import { getAll, getRoleById } from "../controllers/role-controller";
// const userController = require("../controllers/user-controller");
// const authenticateMiddleware = require("../middlewares/authticate");
const router: Router = express.Router();

router.get("/", getAll);
router.get("/:id", getRoleById);

export default router;
