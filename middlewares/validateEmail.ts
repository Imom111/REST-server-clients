// Imports from other node packages
import { NextFunction, Request, Response } from "express";
import { validationResult } from "express-validator";
import Customer from "../models/Customer.model";

export const checkEmailCustomer = async( req: Request ,res: Response, next: NextFunction ) => {
    const { id } = req.params;
    const { email } = req.body;
    const exists = await Customer.findOne({ where: { email }});
    if ( exists ) {
        if ( exists?.dataValues.idCustomer != Number(id)) {
            return res.status(400).json({
                msg: `The email ${ email } is already registered`
            });
        }
    }
    next();
}