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
exports.logOut = exports.logIn = void 0;
const bcryptjs_1 = __importDefault(require("bcryptjs"));
const User_model_1 = __importDefault(require("../models/User.model"));
const create_jwt_1 = require("../helpers/create-jwt");
const logIn = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const { user, password } = req.body;
        const userObj = yield User_model_1.default.findOne({ where: { name: user } });
        if (!userObj) {
            return res.status(400).json({
                msg: 'User not found',
                ok: false
            });
        }
        if (!userObj.dataValues.status) {
            return res.status(400).json({
                msg: 'User inactive',
                ok: false
            });
        }
        const validPassword = bcryptjs_1.default.compareSync(password, userObj.dataValues.password);
        if (!validPassword) {
            return res.status(400).json({
                msg: 'User or password are not correct',
                ok: false
            });
        }
        const token = yield (0, create_jwt_1.generarJWT)(userObj.dataValues.id);
        return res.json({
            token,
            ok: true
        });
    }
    catch (error) {
        console.log(error);
        res.status(500).json({
            msg: "Failed to login"
        });
    }
});
exports.logIn = logIn;
const logOut = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const { user } = req.body;
        console.log(user);
        res.json({
            token: 'Sesión cerrada'
        });
    }
    catch (error) {
        console.log(error);
        res.status(500).json({
            msg: "Failed to login"
        });
    }
});
exports.logOut = logOut;
//# sourceMappingURL=login.controller.js.map