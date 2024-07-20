// import express, { Router } from "express";
const express = require("express");
// import { getAll, getUserById } from "../controllers/user-controller";
const userController = require("../controllers/user-controller");
// const authenticateMiddleware = require("../middlewares/authticate");
const router = express.Router();

router.get("/", userController.getAll);
router.get("/:id", userController.getUserById);

module.exports = router;
