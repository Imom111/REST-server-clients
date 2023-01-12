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
exports.validateJWT = void 0;
const jsonwebtoken_1 = __importDefault(require("jsonwebtoken"));
const User_model_1 = __importDefault(require("./../models/User.model"));
const validateJWT = (req, res, next) => __awaiter(void 0, void 0, void 0, function* () {
    const { token } = req.query;
    if (!token) {
        return res.status(401).json({
            msg: 'No se recibió token'
        });
    }
    try {
        const { idUser } = jsonwebtoken_1.default.verify(String(token), process.env.SECRETORPRIVATEKEY || '');
        const user = yield User_model_1.default.findByPk(Number(idUser));
        if (!user) {
            return res.status(401).json({
                msg: 'User not found'
            });
        }
        if (!user.dataValues.status) {
            return res.status(401).json({
                msg: 'User not active'
            });
        }
        req.user = user.dataValues;
        next();
    }
    catch (error) {
        console.log(error);
        return res.status(401).json({
            msg: `Invalid token`
        });
    }
});
exports.validateJWT = validateJWT;
//# sourceMappingURL=jwt-validate%20copy.js.map