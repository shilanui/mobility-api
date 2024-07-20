require("dotenv").config();
import express, { Request, Response } from "express";
import cors from "cors";
import morgan from "morgan";

// const notFoundMiddleware = require("./middlewares/not-found");
// const errorMiddleware = require("./middlewares/error");
// const rateLimitMiddleware = require("./middlewares/rate-limit");
import userRoute from "./routes/user-route";
// const productRoute = require("./routes/product-route");

const app = express();

app.use(cors());
app.use(morgan("dev"));
// app.use(rateLimitMiddleware);
app.use(express.json());
app.use(express.static("public"));

app.use("/user", userRoute);

const PORT = process.env.PORT || "5000";
app.listen(PORT, () => console.log(`server running on port: ${PORT}`));
