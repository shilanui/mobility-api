require("dotenv").config();
import express from "express";
import cors from "cors";
import morgan from "morgan";

import userRoute from "./routes/user-route";
import roleRoute from "./routes/role-route";
// const productRoute = require("./routes/product-route");

const app = express();

app.use(cors());
app.use(morgan("dev"));
// app.use(rateLimitMiddleware);
app.use(express.json());
app.use(express.static("public"));

app.use("/user", userRoute);
app.use("/role", roleRoute);

const PORT = process.env.PORT || "5000";
app.listen(PORT, () => console.log(`server running on port: ${PORT}`));
