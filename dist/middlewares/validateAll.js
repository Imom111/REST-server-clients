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
exports.validateAll = exports.existsUserByName = exports.existsUserByEmail = exports.existsCustomerByEmail = void 0;
const express_validator_1 = require("express-validator");
const Customer_model_1 = __importDefault(require("../models/Customer.model"));
const User_model_1 = __importDefault(require("../models/User.model"));
/**
 * It checks if a customer with the given email exists in the database
 * @param {string} email - string - The email to check
 * @returns A boolean value
 */
const existsCustomerByEmail = (req, res, next) => __awaiter(void 0, void 0, void 0, function* () {
    const email = req.body.email;
    const customer = yield Customer_model_1.default.findOne({ where: { email } });
    if (customer) {
        const id = req.params.id || 0;
        if (customer.dataValues.idCustomer != id) {
            return res.status(404).json({
                msg: `The email ${email} is already registered`
            });
        }
    }
    next();
});
exports.existsCustomerByEmail = existsCustomerByEmail;
const existsUserByEmail = (req, res, next) => __awaiter(void 0, void 0, void 0, function* () {
    const email = req.body.email;
    const user = yield User_model_1.default.findOne({ where: { email } });
    if (user) {
        const id = req.params.id || 0;
        if (user.dataValues.idUser != id) {
            return res.status(404).json({
                msg: `The email ${email} is already registered`
            });
        }
    }
    next();
});
exports.existsUserByEmail = existsUserByEmail;
const existsUserByName = (req, res, next) => __awaiter(void 0, void 0, void 0, function* () {
    const name = req.body.name;
    const user = yield User_model_1.default.findOne({ where: { name } });
    if (user) {
        const id = req.params.id || 0;
        if (user.dataValues.idUser != id) {
            return res.status(404).json({
                msg: `The name ${name} is already registered`
            });
        }
    }
    next();
});
exports.existsUserByName = existsUserByName;
/**
 * It takes in a request, response, and next function, and returns a response with a 400 status code
 * and the errors if there are any
 * @param {Request} req - Request - The request object
 * @param {Response} res - Response - This is the response object that we will use to send the response
 * back to the client.
 * @param {NextFunction} next - This is a function that we call when we're done with our middleware.
 * @returns An array of errors.
 */
const validateAll = (req, res, next) => {
    const errors = (0, express_validator_1.validationResult)(req);
    if (!errors.isEmpty()) {
        return res.status(400).json(errors);
    }
    next();
};
exports.validateAll = validateAll;
//# sourceMappingURL=validateAll.js.map