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
exports.deleteMunicipality = exports.putMunicipality = exports.postMunicipality = exports.searchMunicipalitiesByAttribute = exports.getMunicipality = exports.getMunicipalitiesByState = exports.getMunicipalities = void 0;
const sequelize_1 = require("sequelize");
// Imports from other this project packages
const Municipality_model_1 = __importDefault(require("../models/Municipality.model"));
const State_model_1 = __importDefault(require("../models/State.model"));
/**
 * It gets all the municipalities from the database and returns them in a JSON response
 * @param {Request} req - Request - This is the request object that contains all the information about
 * the request that was made to the server.
 * @param {Response} res - Response: This is the response object that will be sent back to the client.
 */
const getMunicipalities = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const municipalities = yield Municipality_model_1.default.findAll();
        res.json({
            municipalities
        });
    }
    catch (error) {
        console.log(error);
        res.status(500).json({
            msg: "It wasn't possible to get the municipalities"
        });
    }
});
exports.getMunicipalities = getMunicipalities;
/**
 * It gets the municipalities associated with a state
 * @param {Request} req - Request: This is the request object that contains the request information.
 * @param {Response} res - Response: This is the response object that will be sent to the client.
 */
const getMunicipalitiesByState = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const { id } = req.params;
        const state = yield State_model_1.default.findByPk(id);
        if (state) {
            const municipalities = yield Municipality_model_1.default.findAll({
                where: {
                    idState_Municipality: id
                }
            });
            if (municipalities) {
                res.json({
                    municipalities
                });
            }
            else {
                res.status(404).json({
                    msg: `The state with id ${id} doesn't have associated municipalities.`
                });
            }
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
            msg: "It wasn't possible to get the municipalities"
        });
    }
});
exports.getMunicipalitiesByState = getMunicipalitiesByState;
/**
 * It gets a municipality from the database by its id
 * @param {Request} req - Request - This is the request object that contains the request information.
 * @param {Response} res - Response: This is the response object that will be sent back to the client.
 */
const getMunicipality = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const { id } = req.params;
        const municipality = yield Municipality_model_1.default.findByPk(id);
        if (municipality) {
            res.json({
                municipality
            });
        }
        else {
            res.status(404).json({
                msg: `The municipality with id ${id} does not exist in the database.`
            });
        }
    }
    catch (error) {
        console.log(error);
        res.status(500).json({
            msg: "It wasn't possible to get the municipality"
        });
    }
});
exports.getMunicipality = getMunicipality;
/**
 * It searches for a municipality by a given attribute and a query
 * @param {Request} req - Request - This is the request object that contains the request information.
 * @param {Response} res - Response: This is the response object that will be sent back to the client.
 */
const searchMunicipalitiesByAttribute = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const { attribute } = req.params;
        const { query } = req.query;
        const search_value = { [sequelize_1.Op.like]: `%${query}%` };
        const q = Object.fromEntries([[attribute, search_value]]);
        const municipality = yield Municipality_model_1.default.findAll({
            where: q
        });
        if (municipality) {
            res.json({
                municipality
            });
        }
        else {
            res.status(404).json({
                msg: `The municipality ${attribute}: ${query} does not exist in the database.`
            });
        }
    }
    catch (error) {
        console.log(error);
        res.status(500).json({
            msg: "It wasn't possible to get the municipality"
        });
    }
});
exports.searchMunicipalitiesByAttribute = searchMunicipalitiesByAttribute;
/**
 * It receives a request and a response, and it tries to save a municipality, and if it fails, it
 * returns a 500 status code with a message
 * @param {Request} req - Request - This is the request object that contains the data sent by the
 * client.
 * @param {Response} res - Response: This is the response object that will be sent back to the client.
 * @returns A function that receives a request and a response.
 */
const postMunicipality = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const { body } = req;
        const exists = yield Municipality_model_1.default.findOne({
            where: {
                [sequelize_1.Op.and]: [
                    { name: body.name },
                    { idState_Municipality: body.idState_Municipality }
                ]
            }
        });
        if (exists) {
            return res.status(400).json({
                msg: 'This municipality already exists'
            });
        }
        const municipality = Municipality_model_1.default.build(body);
        yield municipality.save();
        res.json({
            msg: 'Muncipality saved successfully'
        });
    }
    catch (error) {
        console.log(error);
        res.status(500).json({
            msg: "Failed to save municipality"
        });
    }
});
exports.postMunicipality = postMunicipality;
/**
 * It updates a municipality in the database
 * @param {Request} req - Request - This is the request object that contains the request information.
 * @param {Response} res - Response - This is the response object that will be sent back to the client.
 * @returns A function that takes in a request and response object.
 */
const putMunicipality = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const { id } = req.params;
        const { body } = req;
        const municipality = yield Municipality_model_1.default.findByPk(id);
        if (!municipality) {
            return res.status(404).json({
                msg: `The municipality with id ${id} does not exist in the database.`
            });
        }
        yield municipality.update(body);
        res.json({
            msg: 'Municipality updated successfully'
        });
    }
    catch (error) {
        console.log(error);
        res.status(500).json({
            msg: "Could not update municipality"
        });
    }
});
exports.putMunicipality = putMunicipality;
/**
 * It deletes a municipality by changing its status to false
 * @param {Request} req - Request - This is the request object that contains the data sent from the
 * client.
 * @param {Response} res - Response: This is the response object that we will use to send a response
 * back to the client.
 * @returns The status of the municipality is being changed to inactive.
 */
const deleteMunicipality = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const { id } = req.params;
        const municipality = yield Municipality_model_1.default.findByPk(id);
        if (!municipality) {
            return res.status(404).json({
                msg: `The municipality with id ${id} does not exist in the database.`
            });
        }
        yield municipality.update({ status: false });
        res.json({
            msg: 'The status municipality has changed to inactive'
        });
    }
    catch (error) {
        console.log(error);
        res.status(500).json({
            msg: 'Could not delete municipality'
        });
    }
});
exports.deleteMunicipality = deleteMunicipality;
//# sourceMappingURL=municipaly.controller.js.map