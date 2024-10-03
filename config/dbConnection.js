const mongoose = require("mongoose");

const db_connect = async () => {
  try {
    const connection = await mongoose.connect(process.env.MONGO_DB);
    console.log(
      `Connected to mongoD: ${connection.connection.name}, ${connection.connection.host}`
    );
  } catch (error) {
    console.log(error);
    process.exit(1);
  }
};

module.exports = db_connect;
