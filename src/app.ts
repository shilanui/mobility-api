require("dotenv").config();
import express from "express";
import cors from "cors";
import morgan from "morgan";

import vehicleRoute from "./routes/vehicle-route";
import fleetRoute from "./routes/fleet-route";
import eventRoute from "./routes/event-route";

const app = express();

const API_VERSION = process.env.API_VERSION || "v1";

app.use(cors());
app.use(morgan("dev"));
// app.use(rateLimitMiddleware);
app.use(express.json());
app.use(express.static("public"));

app.use(`/api/${API_VERSION}/vehicles`, vehicleRoute);
app.use(`/api/${API_VERSION}/fleet`, fleetRoute);
app.use(`/api/${API_VERSION}/event`, eventRoute);

const PORT = process.env.PORT || "5000";
app.listen(PORT, () => console.log(`server running on port: ${PORT}`));
