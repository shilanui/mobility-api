const prisma = require("../models/prisma");

exports.getAll = async (req, res, next) => {
  try {
    console.log("getAll");
    // const { params } = req;
    // console.log("req =", req.params.id);

    // let user;

    // let user = await prisma.user.findMany();

    // user = await prisma.User.findFirst({
    //   where: {
    //     id: +params.id,
    //   },
    // });

    res.status(201).json({ user: "test" });
    // res.status(201).json({ user });
  } catch (err) {
    next(err);
  }
};

exports.getUserById = async (req, res, next) => {
  try {
    console.log("getUserById");
    // const { params } = req;
    // console.log("req =", req.params.id);

    // let user;

    let user = await prisma.user.findMany();

    // user = await prisma.User.findFirst({
    //   where: {
    //     id: +params.id,
    //   },
    // });

    res.status(201).json({ user });
    // res.status(201).json({ user });
  } catch (err) {
    next(err);
  }
};
