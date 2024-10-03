const express = require("express");
const db_connect = require("./config/dbConnection");
const userRouter = require("./router/userRouter");
const errorHandle = require("./middleware/errorHandler");
const noteRouter = require("./router/noteRouter");
const dotenv = require("dotenv").config();
const app = express();

db_connect();
const PORT = process.env.PORT || 3000;

app.use(express.json());
app.use("/api/users", userRouter);
app.use("/api/notes", noteRouter);
app.get("/", (req, res) => res.send("Welcome to the Get-Contact API!"));
app.use(errorHandle);
app.listen(PORT, () => {
  console.log(`Connected to server ${PORT}`);
});
