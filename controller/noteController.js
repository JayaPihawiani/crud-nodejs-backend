const asyncHandler = require("express-async-handler");
const Notes = require("../models/noteModel");

const addNotes = asyncHandler(async (req, res) => {
  const { name, description } = req.body;
  if (name && description) {
    const notes = await Notes.create({
      name,
      description,
      userID: req.user.id,
    });
    res.status(201).json(notes);
  } else {
    res.status(400);
    throw new Error("Field ada yang kosong");
  }
});

const updateNotes = asyncHandler(async (req, res) => {
  const notes = await Notes.findById(req.params.id);
  if (!notes) {
    res.status(404);
    throw new Error("Note kosong.");
  }
  if (notes.userID.toString() === req.user.id) {
    const noteUpdate = await Notes.findByIdAndUpdate(req.params.id, req.body, {
      new: true,
    });
    res.status(200).json(noteUpdate);
  } else {
    res.status(403);
    throw new Error("Gagal mengupdate note.");
  }
});

const deleteNotes = asyncHandler(async (req, res) => {
  const notes = await Notes.findById(req.params.id);
  if (!notes) {
    res.status(404);
    throw new Error("Note kosong.");
  }
  if (notes.userID.toString() === req.user.id) {
    const noteDelete = await Notes.findByIdAndDelete(req.params.id);
    res.status(200).json(noteDelete);
  } else {
    res.status(403);
    throw new Error("Gagal mengupdate note.");
  }
});

const getAllNotes = asyncHandler(async (req, res) => {
  const notes = await Notes.find({ userID: req.user.id });
  res.status(200).json(notes);
});

module.exports = { getAllNotes, addNotes, updateNotes, deleteNotes };
