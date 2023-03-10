"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
/* Importing the DataTypes and the connection to the database. */
const sequelize_1 = require("sequelize");
const connection_1 = __importDefault(require("../db/connection"));
/* Creating a table in the database. */
const State = connection_1.default.define('State', {
    idState: {
        type: sequelize_1.DataTypes.INTEGER,
        autoIncrement: true,
        primaryKey: true
    },
    name: {
        type: sequelize_1.DataTypes.STRING,
        allowNull: false
    },
    status: {
        type: sequelize_1.DataTypes.BOOLEAN,
        defaultValue: true
    }
}, {
    tableName: 'state',
    timestamps: false,
    createdAt: false
});
exports.default = State;
//# sourceMappingURL=State.model.js.map