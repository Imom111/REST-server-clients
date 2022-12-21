"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
/* Importing the DataTypes from the sequelize package, the db connection from the db/connection file,
and the Municipality model from the Municipality.model file. */
const sequelize_1 = require("sequelize");
const connection_1 = __importDefault(require("../db/connection"));
const Municipality_model_1 = __importDefault(require("./Municipality.model"));
/* Creating a table in the database with the name of the model. */
const Customer = connection_1.default.define('Customer', {
    idCustomer: {
        type: sequelize_1.DataTypes.INTEGER,
        autoIncrement: true,
        primaryKey: true
    },
    full_name: {
        type: sequelize_1.DataTypes.STRING,
        allowNull: false
    },
    phone: {
        type: sequelize_1.DataTypes.STRING,
        allowNull: false
    },
    email: {
        type: sequelize_1.DataTypes.STRING,
        allowNull: false
    },
    housing: {
        type: sequelize_1.DataTypes.STRING,
        allowNull: false
    },
    street: {
        type: sequelize_1.DataTypes.STRING,
        allowNull: false
    },
    postal_code: {
        type: sequelize_1.DataTypes.INTEGER,
        allowNull: false
    },
    status: {
        type: sequelize_1.DataTypes.BOOLEAN,
        defaultValue: true
    },
    idMunicipality_Customer: {
        type: sequelize_1.DataTypes.INTEGER,
        references: {
            model: Municipality_model_1.default,
            key: 'idMunicipality'
        },
        allowNull: false
    }
}, {
    tableName: 'customer',
    timestamps: false,
    createdAt: false
});
exports.default = Customer;
//# sourceMappingURL=Customer.model.js.map