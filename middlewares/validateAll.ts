// Imports from other node packages
import { NextFunction, Request, Response } from "express";
import { validationResult } from "express-validator";
import Customer from "../models/Customer.model";

/**
 * It checks if a customer with the given email exists in the database
 * @param {string} email - string - The email to check
 * @returns A boolean value
 */
export const existsCustomerByEmail = async( req: Request ,res: Response, next: NextFunction ) => {
    const email = req.body.email;
    const id = req.params.id;
    const customer = await Customer.findOne({ where: { email }});
    if ( customer ) {
        if ( customer.dataValues.idCustomer != id ) {
            throw new Error(`The email ${ email } is already registered`);
        }
    }
    next();
}

/**
 * It takes in a request, response, and next function, and returns a response with a 400 status code
 * and the errors if there are any
 * @param {Request} req - Request - The request object
 * @param {Response} res - Response - This is the response object that we will use to send the response
 * back to the client.
 * @param {NextFunction} next - This is a function that we call when we're done with our middleware.
 * @returns An array of errors.
 */
export const validateAll = ( req: Request ,res: Response, next: NextFunction ) => {
    const errors = validationResult(req);
    if ( !errors.isEmpty() ) {
        return res.status(400).json(errors);
    }
    next();
}