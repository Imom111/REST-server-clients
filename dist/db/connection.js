"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
/* This is importing the Sequelize library and the dotenv library. */
const sequelize_1 = require("sequelize");
require('dotenv').config();
/* This is creating a new instance of Sequelize. */
const db = new sequelize_1.Sequelize(String(process.env.DB_URI));
exports.default = db;
//# sourceMappingURL=connection.js.map