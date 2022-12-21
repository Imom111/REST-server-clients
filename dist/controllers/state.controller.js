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
const State_model_1 = __importDefault(require("../models/State.model"));
const getStates = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const states = yield State_model_1.default.findAll();
        res.json({
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
const postState = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const { body } = req;
        const exists = yield State_model_1.default.findOne({
            where: { name: body.name }
        });
        if (exists) {
            return res.status(400).json({
                msg: 'This state already exists'
            });
        }
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