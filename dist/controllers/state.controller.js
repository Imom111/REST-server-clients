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
exports.deleteState = exports.putState = exports.postState = exports.searchStatesByAttribute = exports.getState = exports.getStates = void 0;
const sequelize_1 = require("sequelize");
// Imports from other this project packages
const State_model_1 = __importDefault(require("../models/State.model"));
/**
 * It's a function that receives a request and a response, and it returns a json with all the states
 * @param {Request} req - Request - This is the request object that contains all the information about
 * the request.
 * @param {Response} res - Response - This is the response object that will be sent back to the client.
 */
const getStates = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const states = yield State_model_1.default.findAll();
        res.status(200).json({
            states
        });
    }
    catch (error) {
        console.log(error);
        res.status(500).json({
            msg: "It wasn't possible to get the states"
        });
    }
});
exports.getStates = getStates;
/**
 * It gets a state from the database and returns it as a JSON object
 * @param {Request} req - Request - This is the request object that contains the request information.
 * @param {Response} res - Response: This is the response object that will be sent back to the client.
 */
const getState = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const { id } = req.params;
        const state = yield State_model_1.default.findByPk(id);
        if (state) {
            res.json({
                state
            });
        }
        else {
            res.status(404).json({
                msg: `The state with id ${id} does not exist in the database.`
            });
        }
    }
    catch (error) {
        console.log(error);
        res.status(500).json({
            msg: "It wasn't possible to get the state"
        });
    }
});
exports.getState = getState;
/**
 * It searches for a state by a given attribute and returns the state if it exists
 * @param {Request} req - Request - This is the request object that contains the request information.
 * @param {Response} res - Response - The response object that will be sent back to the client.
 */
const searchStatesByAttribute = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const { attribute } = req.params;
        const { query } = req.query;
        const search_value = { [sequelize_1.Op.like]: `%${query}%` };
        const q = Object.fromEntries([[attribute, search_value]]);
        const state = yield State_model_1.default.findAll({
            where: q
        });
        if (state) {
            res.json({
                state
            });
        }
        else {
            res.status(404).json({
                msg: `The state ${attribute}: ${query} does not exist in the database.`
            });
        }
    }
    catch (error) {
        console.log(error);
        res.status(500).json({
            msg: "It wasn't possible to get the state"
        });
    }
});
exports.searchStatesByAttribute = searchStatesByAttribute;
/**
 * It receives a request and a response object, and it tries to save a new state in the database
 * @param {Request} req - Request - This is the request object that contains the data sent from the
 * client.
 * @param {Response} res - Response - This is the response object that will be sent back to the client.
 * @returns A function that takes in a request and response object.
 */
const postState = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const { body } = req;
        const state = State_model_1.default.build(body);
        yield state.save();
        res.json({
            msg: 'State saved successfully'
        });
    }
    catch (error) {
        console.log(error);
        res.status(500).json({
            msg: "Failed to save state"
        });
    }
});
exports.postState = postState;
/**
 * It updates a state in the database
 * @param {Request} req - Request - This is the request object that contains the request information.
 * @param {Response} res - Response - This is the response object that will be sent back to the client.
 * @returns The state with the id that was passed in the request params.
 */
const putState = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    const { id } = req.params;
    const { body } = req;
    try {
        const state = yield State_model_1.default.findByPk(id);
        if (!state) {
            return res.status(404).json({
                msg: `The state with id ${id} does not exist in the database.`
            });
        }
        yield state.update(body);
        res.json({
            msg: 'State updated successfully'
        });
    }
    catch (error) {
        console.log(error);
        res.status(500).json({
            msg: "Could not update state"
        });
    }
});
exports.putState = putState;
/**
 * It finds a state by its id, if it exists, it changes its status to false, if it doesn't exist, it
 * returns a 404 error
 * @param {Request} req - Request - This is the request object that contains the data sent from the
 * client.
 * @param {Response} res - Response: This is the response object that will be sent back to the client.
 * @returns The state with the id that was passed in the params.
 */
const deleteState = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const { id } = req.params;
        const state = yield State_model_1.default.findByPk(id);
        if (!state) {
            return res.status(404).json({
                msg: `The state with id ${id} does not exist in the database.`
            });
        }
        yield state.update({ status: false });
        res.json({
            msg: 'The status state has changed to inactive'
        });
    }
    catch (error) {
        console.log(error);
        res.status(500).json({
            msg: 'Could not delete state'
        });
    }
});
exports.deleteState = deleteState;
//# sourceMappingURL=state.controller.js.map