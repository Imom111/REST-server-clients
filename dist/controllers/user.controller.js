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
exports.deleteUser = exports.putUser = exports.postUser = exports.searchUsersByAttribute = exports.searchUsers = exports.getUser = exports.getUsers = void 0;
const sequelize_1 = require("sequelize");
const connection_1 = __importDefault(require("../db/connection"));
// Imports from other this project packages
const User_model_1 = __importDefault(require("../models/User.model"));
const getUsers = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const users = yield User_model_1.default.findAll({
            where: { status: true }
        });
        res.status(200).json({
            users
        });
    }
    catch (error) {
        console.log(error);
        res.status(500).json({
            msg: "It wasn't possible to get the users"
        });
    }
});
exports.getUsers = getUsers;
const getUser = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const { id } = req.params;
        const user = yield User_model_1.default.findByPk(id);
        if (user) {
            res.json({
                user
            });
        }
        else {
            res.status(404).json({
                msg: `The user with id ${id} does not exist in the database.`
            });
        }
    }
    catch (error) {
        console.log(error);
        res.status(500).json({
            msg: "It wasn't possible to get the user"
        });
    }
});
exports.getUser = getUser;
const searchUsers = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    const { query } = req.query;
    const users = yield connection_1.default.query(`CALL searchUser ("${query}")`, {
        type: sequelize_1.QueryTypes.SELECT
    });
    res.json({
        users: users[0]
    });
});
exports.searchUsers = searchUsers;
const searchUsersByAttribute = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const { attribute } = req.params;
        const { query } = req.query;
        const search_value = { [sequelize_1.Op.like]: `%${query}%` };
        const q = Object.fromEntries([[attribute, search_value]]);
        const users = yield User_model_1.default.findAll({
            where: q
        });
        if (users) {
            res.json({
                users
            });
        }
        else {
            res.status(404).json({
                msg: `The user with ${attribute} equal to ${query} does not exist in the database.`
            });
        }
    }
    catch (error) {
        console.log(error);
        res.status(500).json({
            msg: "It wasn't possible to get the user"
        });
    }
});
exports.searchUsersByAttribute = searchUsersByAttribute;
const postUser = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const { name, password, email, idRole_User } = req.body;
        yield connection_1.default.query('CALL insert_user(?, ?, ?, ?, 1);', {
            replacements: [name, password, email, Number(idRole_User)]
        });
        res.json({
            msg: 'User saved successfully'
        });
    }
    catch (error) {
        console.log(error);
        res.status(500).json({
            msg: "Failed to save user"
        });
    }
});
exports.postUser = postUser;
const putUser = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const id = req.params.id;
        const { name, password, email, status, idRole_User } = req.body;
        const user = yield User_model_1.default.findByPk(id);
        if (!user) {
            return res.status(404).json({
                msg: `The user with id ${id} does not exist in the database.`
            });
        }
        yield connection_1.default.query('CALL update_user(?, ?, ?, ?, ?, 1);', {
            replacements: [Number(id), name, password, email, Boolean(status), Number(idRole_User)]
        });
        res.json({
            msg: 'User updated successfully'
        });
    }
    catch (error) {
        console.log(error);
        res.status(500).json({
            msg: "Could not update user"
        });
    }
});
exports.putUser = putUser;
const deleteUser = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const { id } = req.params;
        const user = yield User_model_1.default.findByPk(id);
        if (!user) {
            return res.status(404).json({
                msg: `The user with id ${id} does not exist in the database.`
            });
        }
        yield connection_1.default.query('CALL delete_user(?, 1);', {
            replacements: [Number(id)]
        });
        res.json({
            msg: 'The status user has changed to inactive'
        });
    }
    catch (error) {
        console.log(error);
        res.status(500).json({
            msg: 'Could not delete user'
        });
    }
});
exports.deleteUser = deleteUser;
//# sourceMappingURL=user.controller.js.map