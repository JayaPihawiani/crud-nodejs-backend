const express = require("express");
const {
  register,
  login,
  getCurrentUser,
  updateUser,
  getUser,
} = require("../controller/userController");
const validateToken = require("../middleware/validateToken");
const userRouter = express.Router();

userRouter.route("/register").post(register);
userRouter.route("/login").post(login);
userRouter.route("/current").get(validateToken, getCurrentUser);
userRouter.route("/profile").put(validateToken, updateUser);
userRouter.route("/user").get(validateToken, getUser);

module.exports = userRouter;
