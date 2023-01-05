"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.validateAll = void 0;
const express_validator_1 = require("express-validator");
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