"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
/* This is importing the Sequelize library and the dotenv library. */
const sequelize_1 = require("sequelize");
require('dotenv').config();
/* This is creating a new instance of Sequelize. */
const db = new sequelize_1.Sequelize('mysql://uf7ohogomfidsmbi:gPq0q1o0GMdql0SnLNT8@bsiyueg9lxxg8julclbi-mysql.services.clever-cloud.com:3306/bsiyueg9lxxg8julclbi');
exports.default = db;
//# sourceMappingURL=connection.js.map