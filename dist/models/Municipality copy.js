"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const sequelize_1 = require("sequelize");
const connection_1 = __importDefault(require("../db/connection"));
const Municipality = connection_1.default.define('Municipality', {
    name: {
        type: sequelize_1.DataTypes.STRING
    },
    idStates_Municipalities: {
        type: sequelize_1.DataTypes.INTEGER,
        references: {
            model: State,
            key: 'idState'
        }
    },
}, {
    tableName: 'Municipalities'
});
exports.default = Municipality;
//# sourceMappingURL=Municipality%20copy.js.map