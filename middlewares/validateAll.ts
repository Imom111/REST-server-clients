// Imports from other node packages
import { NextFunction, Request, Response } from "express";
import { validationResult } from "express-validator";
import Customer from "../models/Customer.model";
import User from "../models/User.model";

/**
 * It checks if a customer with the given email exists in the database
 * @param {string} email - string - The email to check
 * @returns A boolean value
 */
export const existsCustomerByEmail = async( req: Request ,res: Response, next: NextFunction ) => {
    const email = req.body.email;
    const customer = await Customer.findOne({ where: { email }});
    if ( customer ) {
        const id = req.params.id || 0;
        if ( customer.dataValues.idCustomer != id ) {
            return res.status(404).json({
                msg: `The email ${ email } is already registered`
            });
        }
    }
    next();
}

export const existsUserByEmail = async( req: Request ,res: Response, next: NextFunction ) => {
    const email = req.body.email;
    const user = await User.findOne({ where: { email }});
    if ( user ) {
        const id = req.params.id || 0;
        if ( user.dataValues.idUser != id ) {
            return res.status(404).json({
                msg: `The email ${ email } is already registered`
            });
        }
    }
    next();
}

export const existsUserByName = async( req: Request ,res: Response, next: NextFunction ) => {
    const name = req.body.name;
    const user = await User.findOne({ where: { name }});
    if ( user ) {
        const id = req.params.id || 0;
        if ( user.dataValues.idUser != id ) {
            return res.status(404).json({
                msg: `The name ${ name } is already registered`
            });
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