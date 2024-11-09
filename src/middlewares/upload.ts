// const multer = require("multer");
import multer from "multer";

const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, "public");
  },
  filename: (req, file, cb) => {
    const split = file.originalname.split(".");
    cb(
      null,
      "" +
        Date.now() +
        Math.round(Math.random() * 1000000) +
        "." +
        split[split.length - 1]
    );
  },
});

const uploadMiddleware = multer({ storage: storage });
export default uploadMiddleware;
