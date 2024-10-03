const jwt = require("jsonwebtoken");
const asyncHandler = require("express-async-handler");

const validateToken = asyncHandler(async (req, res, next) => {
  let token;
  let authHeader = req.headers.authorization || req.headers.Authorization;

  try {
    if (authHeader && authHeader.startsWith("Bearer")) {
      token = authHeader.split(" ")[1];
      jwt.verify(token, process.env.JWT_SECRET, (err, decoded) => {
        if (err) {
          throw new Error("User not authorized to access this content");
        }
        req.user = decoded.user;
        next();
      });
    } else {
      throw new Error("Token not provided");
    }
  } catch (error) {
    res.status(401).json({ msg: error.message, stackTrace: error.stack });
  }
});

module.exports = validateToken;
