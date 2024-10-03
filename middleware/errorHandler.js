const { constants } = require("../constants");

const errorHandle = (err, req, res, next) => {
  const statusCode = res.statusCode ? res.statusCode : 500;
  switch (statusCode) {
    case constants.FORBIDDEN:
      res.json({
        title: "Forbidden Acces",
        msg: err.message,
        stackTrace: err.stack,
      });
    case constants.NOT_FOUND:
      res.json({
        title: "Not found",
        msg: err.message,
        stackTrace: err.stack,
      });
    case constants.SERVER_ERROR:
      res.json({
        title: "Server error",
        msg: err.message,
        stackTrace: err.stack,
      });
    case constants.UNAUTHORIZED:
      res.json({
        title: "Unauthorized Acces",
        msg: err.message,
        stackTrace: err.stack,
      });
    case constants.VALIDATION_ERROR:
      res.json({
        title: "Validation error",
        msg: err.message,
        stackTrace: err.stack,
      });

      break;

    default:
      break;
  }
};

module.exports = errorHandle;
