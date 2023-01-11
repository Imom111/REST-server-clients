"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const sequelize_1 = require("sequelize");
const connection_1 = __importDefault(require("../db/connection"));
const Role_model_1 = __importDefault(require("./Role.model"));
const User = connection_1.default.define('user', {
    idUser: {
        type: sequelize_1.DataTypes.INTEGER,
        autoIncrement: true,
        primaryKey: true
    },
    name: {
        type: sequelize_1.DataTypes.STRING,
        allowNull: false
    },
    password: {
        type: sequelize_1.DataTypes.STRING,
        allowNull: false
    },
    email: {
        type: sequelize_1.DataTypes.STRING,
        allowNull: false
    },
    token: {
        type: sequelize_1.DataTypes.STRING,
        allowNull: false
    },
    status: {
        type: sequelize_1.DataTypes.BOOLEAN,
        defaultValue: true
    },
    idRole_User: {
        type: sequelize_1.DataTypes.INTEGER,
        references: {
            model: Role_model_1.default,
            key: 'idRole'
        },
        allowNull: false
    }
}, {
    tableName: 'user',
    timestamps: false,
    createdAt: false
});
exports.default = User;
//# sourceMappingURL=User.model.js.map