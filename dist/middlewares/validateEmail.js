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
exports.checkEmailCustomer = void 0;
const Customer_model_1 = __importDefault(require("../models/Customer.model"));
const checkEmailCustomer = (req, res, next) => __awaiter(void 0, void 0, void 0, function* () {
    const { id } = req.params;
    const { email } = req.body;
    const exists = yield Customer_model_1.default.findOne({ where: { email } });
    if (exists) {
        if ((exists === null || exists === void 0 ? void 0 : exists.dataValues.idCustomer) != Number(id)) {
            return res.status(400).json({
                msg: `The email ${email} is already registered`
            });
        }
    }
    next();
});
exports.checkEmailCustomer = checkEmailCustomer;
//# sourceMappingURL=validateEmail.js.map