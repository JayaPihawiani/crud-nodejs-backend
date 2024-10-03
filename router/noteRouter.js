const express = require("express");
const {
  addNotes,
  getAllNotes,
  updateNotes,
  deleteNotes,
} = require("../controller/noteController");
const validateToken = require("../middleware/validateToken");

const noteRouter = express.Router();

noteRouter.use(validateToken);
noteRouter.route("/").post(addNotes).get(getAllNotes);
noteRouter.route("/:id").put(updateNotes).delete(deleteNotes);

module.exports = noteRouter;
