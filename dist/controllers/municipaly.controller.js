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
exports.deleteMunicipality = exports.putMunicipality = exports.postMunicipality = exports.getMunicipality = exports.getMunicipalitiesByState = exports.getMunicipalities = void 0;
const sequelize_1 = require("sequelize");
const Municipality_model_1 = __importDefault(require("../models/Municipality.model"));
const State_model_1 = __importDefault(require("../models/State.model"));
const getMunicipalities = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    const municipalities = yield Municipality_model_1.default.findAll();
    res.json({
        municipalities
    });
});
exports.getMunicipalities = getMunicipalities;
const getMunicipalitiesByState = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
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
});
exports.getMunicipalitiesByState = getMunicipalitiesByState;
const getMunicipality = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
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
});
exports.getMunicipality = getMunicipality;
const postMunicipality = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    const { body } = req;
    try {
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
            municipality
        });
    }
    catch (error) {
        console.log(error);
        res.status(500).json({
            msg: 'Server error call to administrator'
        });
    }
});
exports.postMunicipality = postMunicipality;
const putMunicipality = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    const { id } = req.params;
    const { body } = req;
    try {
        const municipality = yield Municipality_model_1.default.findByPk(id);
        if (!municipality) {
            return res.status(404).json({
                msg: `The municipality with id ${id} does not exist in the database.`
            });
        }
        yield municipality.update(body);
        res.json({
            municipality
        });
    }
    catch (error) {
        console.log(error);
        res.status(500).json({
            msg: 'Server error call to administrator'
        });
    }
});
exports.putMunicipality = putMunicipality;
const deleteMunicipality = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    const { id } = req.params;
    try {
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
            msg: 'Server error call to administrator'
        });
    }
});
exports.deleteMunicipality = deleteMunicipality;
//# sourceMappingURL=municipaly.controller.js.map