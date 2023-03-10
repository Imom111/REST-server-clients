"use strict";
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.searchLogs = exports.logsLogins = exports.logsUsers = exports.logsMunicipalities = exports.logsStates = exports.logsCustomer = exports.logsAll = void 0;
const sequelize_1 = require("sequelize");
const connection_1 = __importDefault(require("../db/connection"));
const create_description_log_1 = require("../helpers/create-description-log");
const logsAll = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const log = yield connection_1.default.query(`SELECT * FROM logAll`, {
            type: sequelize_1.QueryTypes.SELECT
        });
        let logFinal = [];
        for (let index = 0; index < log.length; index++) {
            logFinal.push((0, create_description_log_1.createDescriptionLog)(log[index]));
        }
        res.json({
            resutls: logFinal
        });
    }
    catch (error) {
        console.log(error);
        res.status(500).json({
            msg: "Error getting logs"
        });
    }
});
exports.logsAll = logsAll;
const logsCustomer = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const log = yield connection_1.default.query(`SELECT * FROM logCustomer`, {
            type: sequelize_1.QueryTypes.SELECT
        });
        let logFinal = [];
        for (let index = 0; index < log.length; index++) {
            logFinal.push((0, create_description_log_1.createDescriptionLog)(log[index]));
        }
        res.json({
            resutls: logFinal
        });
    }
    catch (error) {
        console.log(error);
        res.status(500).json({
            msg: "Error getting customer logs"
        });
    }
});
exports.logsCustomer = logsCustomer;
const logsStates = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const log = yield connection_1.default.query(`SELECT * FROM logState`, {
            type: sequelize_1.QueryTypes.SELECT
        });
        let logFinal = [];
        for (let index = 0; index < log.length; index++) {
            logFinal.push((0, create_description_log_1.createDescriptionLog)(log[index]));
        }
        res.json({
            resutls: logFinal
        });
    }
    catch (error) {
        console.log(error);
        res.status(500).json({
            msg: "Error getting state logs"
        });
    }
});
exports.logsStates = logsStates;
const logsMunicipalities = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const log = yield connection_1.default.query(`SELECT * FROM logMunicipality`, {
            type: sequelize_1.QueryTypes.SELECT
        });
        let logFinal = [];
        for (let index = 0; index < log.length; index++) {
            logFinal.push((0, create_description_log_1.createDescriptionLog)(log[index]));
        }
        res.json({
            resutls: logFinal
        });
    }
    catch (error) {
        console.log(error);
        res.status(500).json({
            msg: "Error getting municipality logs"
        });
    }
});
exports.logsMunicipalities = logsMunicipalities;
const logsUsers = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const log = yield connection_1.default.query(`SELECT * FROM logUser`, {
            type: sequelize_1.QueryTypes.SELECT
        });
        let logFinal = [];
        for (let index = 0; index < log.length; index++) {
            logFinal.push((0, create_description_log_1.createDescriptionLog)(log[index]));
        }
        res.json({
            resutls: logFinal
        });
    }
    catch (error) {
        console.log(error);
        res.status(500).json({
            msg: "Error getting user logs"
        });
    }
});
exports.logsUsers = logsUsers;
const logsLogins = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const log = yield connection_1.default.query(`SELECT * FROM logLogin`, {
            type: sequelize_1.QueryTypes.SELECT
        });
        let logFinal = [];
        for (let index = 0; index < log.length; index++) {
            logFinal.push((0, create_description_log_1.createDescriptionLog)(log[index]));
        }
        res.json({
            resutls: logFinal
        });
    }
    catch (error) {
        console.log(error);
        res.status(500).json({
            msg: "Error getting user logs"
        });
    }
});
exports.logsLogins = logsLogins;
const searchLogs = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    const { query } = req.query;
    const logs = yield connection_1.default.query(`CALL searchLog ("${query}")`, {
        type: sequelize_1.QueryTypes.SELECT
    });
    let logFinal = [];
    const logAll = Object.values(logs[0]);
    for (let index = 0; index < logAll.length; index++) {
        logFinal.push((0, create_description_log_1.createDescriptionLog)(logAll[index]));
    }
    console.log(logFinal);
    res.json({
        resutls: logFinal
    });
});
exports.searchLogs = searchLogs;
//# sourceMappingURL=log.controller.js.map