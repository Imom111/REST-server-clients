"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const sequelize_1 = require("sequelize");
const connection_1 = __importDefault(require("../db/connection"));
const State_1 = __importDefault(require("./State"));
const Municipality = connection_1.default.define('Municipality', {
    idMunicipality: {
        type: sequelize_1.DataTypes.INTEGER,
        autoIncrement: true,
        primaryKey: true
    },
    name: {
        type: sequelize_1.DataTypes.STRING
    },
    status: {
        type: sequelize_1.DataTypes.BOOLEAN,
        defaultValue: true
    },
    idState_Municipality: {
        type: sequelize_1.DataTypes.INTEGER,
        references: {
            model: State_1.default,
            key: 'idState'
        }
    }
}, {
    tableName: 'municipality',
    timestamps: false,
    createdAt: false
});
exports.default = Municipality;
//# sourceMappingURL=Municipality.js.map