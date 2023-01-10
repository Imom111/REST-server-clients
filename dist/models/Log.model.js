"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const sequelize_1 = require("sequelize");
const connection_1 = __importDefault(require("../db/connection"));
const User_model_1 = __importDefault(require("./User.model"));
const Log = connection_1.default.define('Log', {
    idLog: {
        type: sequelize_1.DataTypes.INTEGER,
        autoIncrement: true,
        primaryKey: true
    },
    description: {
        type: sequelize_1.DataTypes.STRING,
        allowNull: false
    },
    date: {
        type: sequelize_1.DataTypes.DATE,
        allowNull: false
    },
    idUser_Log: {
        type: sequelize_1.DataTypes.INTEGER,
        references: {
            model: User_model_1.default,
            key: 'idUser'
        },
        allowNull: false
    }
}, {
    tableName: 'log',
    timestamps: false,
    createdAt: false
});
exports.default = Log;
//# sourceMappingURL=Log.model.js.map