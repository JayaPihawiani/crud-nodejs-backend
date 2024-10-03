// modul
const User = require("../models/userSchema");
const asyncHandler = require("express-async-handler");
const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");

// register
const register = asyncHandler(async (req, res) => {
  const { name, email, password, phone } = req.body;
  if (name && email && password && phone) {
    const validEmail = await User.findOne({ email });
    if (validEmail) {
      res.status(400);
      throw new Error("Email ini sudah digunakan");
    } else {
      if (password.length < 8) {
        res.status(400);
        throw new Error("Password terlalu pendek. Minimal harus 8 karakter");
      } else {
        try {
          const salt = await bcrypt.genSalt(10);
          const hasedPassword = await bcrypt.hash(password, salt);
          const user = await User.create({
            name,
            email,
            password: hasedPassword,
            phone,
          });

          if (user) {
            res.status(201).json({
              _id: user.id,
              name: user.name,
              email: user.email,
              phone: user.phone,
            });
          }
        } catch (error) {
          res.status(400).json({ msg: error.message });
        }
      }
    }
  } else {
    res.status(400);
    throw new Error("Field ada yang kosong. Harap isi semua field");
  }
});

// login
const login = asyncHandler(async (req, res) => {
  const { email, password } = req.body;

  if (!email || !password) {
    res.status(400);
    throw new Error("Field ada yang kosong. Harap isi semua field.");
  }
  const user = await User.findOne({ email });
  try {
    if (user) {
      if (await bcrypt.compare(password, user.password)) {
        const token = jwt.sign(
          {
            user: {
              id: user.id,
              name: user.name,
              email: user.email,
              phone: user.phone,
            },
          },
          process.env.JWT_SECRET,
          { expiresIn: "8h" }
        );

        res.status(200).json({
          token,
          user: {
            id: user.id,
            name: user.name,
            email: user.email,
            phone: user.phone,
          },
        });
      } else {
        throw new Error("Password salah. Harap cek ulang password.");
      }
    } else {
      throw new Error("Email tidak ditemukan. Harap cek ulang email.");
    }
  } catch (error) {
    res.status(401).json({ msg: error.message, stack: error.stack });
  }
});

const updateUser = asyncHandler(async (req, res) => {
  const user = await User.findById(req.user.id);
  if (!user) {
    console.log(user);
    res.status(404);
    throw new Error("User not found");
  }
  const updateUser = await User.findByIdAndUpdate(req.user.id, req.body, {
    new: true,
  });
  res.status(200).json(updateUser);
});

const getUser = asyncHandler(async (req, res) => {
  const user = await User.findById(req.user.id);

  res.status(200).json({
    name: user.name,
    email: user.email,
    phone: user.phone,
  });
});

// getUser
const getCurrentUser = asyncHandler(async (req, res) => {
  res.status(200).json(req.user);
});

module.exports = { register, login, getCurrentUser, updateUser, getUser };
