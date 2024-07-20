const express = require("express");
const userController = require("../controllers/user-controller");
const authenticateMiddleware = require("../middlewares/authticate");
const router = express.Router();

router.get("/", userController.getAll);
router.get("/:id", authenticateMiddleware, userController.getUserById);

module.exports = router;
