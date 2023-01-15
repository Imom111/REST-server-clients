// Imports from other node packages
import { Request, Response } from "express";
import { Op, QueryTypes } from "sequelize";
import db from "../db/connection";

// Imports from other this project packages
import Customer from "../models/Customer.model";

/**
 * It's an async function that receives a request and a response object, and it tries to find all the
 * customers in the database, and if it succeeds, it sends a response with the customers, otherwise it
 * sends a response with an error message
 * @param {Request} req - Request - This is the request object that contains all the information about
 * the request that was made to the server.
 * @param {Response} res - Response - This is the response object that we will use to send back a
 * response to the client.
 */
export const getCustomers = async( req: Request ,res: Response) => {
    try {
        const customers = await Customer.findAll();
        res.status(200).json({
            customers
        });
    } catch (error) {
        console.log(error);
        res.status(500).json({
            msg: "It wasn't possible to get the customers"
        });
    }
}

/**
 * It gets a customer from the database by its id
 * @param {Request} req - Request - This is the request object that contains the request information.
 * @param {Response} res - Response: This is the response object that we will use to send the response
 * to the client.
 */
export const getCustomer = async( req: Request, res: Response) => {
    try {
        const { id } = req.params;
        const customer = await db.query(
            `SELECT * FROM customer_state WHERE idCustomer = ${Number(id)}`,
            {
                type: QueryTypes.SELECT
            }
        );
        if ( customer[0] ) {
            res.json({
                idCustomer: customer[0].idCustomer,
                full_name: customer[0].full_name,
                phone: customer[0].phone,
                email: customer[0].email,
                housing: customer[0].housing,
                street: customer[0].street,
                postal_code: customer[0].postal_code,
                status: customer[0].status,
                idMunicipality_Customer: customer[0].idMunicipality_Customer,
                idState_Customer: customer[0].idState
            });
        } else {
            res.status(404).json({
                msg: `The customer with id ${ id } does not exist in the database.`
            });
        }
    } catch (error) {
        console.log(error);
        res.status(500).json({
            msg: "It wasn't possible to get the customer"
        });
    }
}

export const searchCustomers = async( req: Request ,res: Response) => {
    const { query } = req.query;
    const customers = await db.query(
        `CALL searchCustomer ("${ query }")`,
        {
            type: QueryTypes.SELECT
        }
    );
    res.json({
        customers: customers[0]
    });
}

/**
 * It searches for a customer by a given attribute and returns the customer if it exists
 * @param {Request} req - Request - This is the request object that contains the request information.
 * @param {Response} res - Response: This is the response object that will be sent back to the client.
 */
export const searchCustomersByAttribute = async( req: Request ,res: Response) => {
    try {
        const { attribute } = req.params;
        const { query } = req.query;
        const search_value = {[Op.like]: `%${query}%`};
        const q = Object.fromEntries( [[attribute, search_value]] );
        const customers = await Customer.findAll({
            where: q
        });
        if ( customers ) {
            res.json({
                customers
            });
        } else {
            res.status(404).json({
                msg: `The customer with ${ attribute } equal to ${ query } does not exist in the database.`
            });
        }
    } catch (error) {
        console.log(error);
        res.status(500).json({
            msg: "It wasn't possible to get the customer"
        });
    }
}


/**
 * It takes a request and a response object, and then it tries to save a customer to the database
 * @param {Request} req - Request - This is the request object that contains the data sent from the
 * client.
 * @param {Response} res - Response - This is the response object that we will use to send a response
 * back to the client.
 */
export const postCustomer = async( req: Request, res: Response) => {
    try {

        const { full_name, phone, email, housing, street, postal_code, idMunicipality_Customer } = req.body;
        
        await db.query(
            'CALL insert_customer(?, ?, ?, ?, ?, ?, ?, ?);', {
                replacements: [full_name, phone, email, housing, street, Number(postal_code), Number(idMunicipality_Customer), Number(req.user.idUser)]
            }
        );
        
        // const customers = await db.query(
        //     `CALL insert_customer ("${ query }")
        // );
            
        // const customer = Customer.build( body );
        // await customer.save();

        res.json({
            msg: 'Customer saved successfully'
        });
    } catch (error) {
        console.log(error);
        res.status(500).json({
            msg: "Failed to save customer"
        });
    }
}

/**
 * It updates a customer in the database
 * @param {Request} req - Request - This is the request object that contains the request information.
 * @param {Response} res - Response - This is the response object that we will use to send a response
 * back to the client.
 * @returns The customer with the id that was passed in the request params.
 */
export const putCustomer = async( req: Request, res: Response) => {
    try {
        const id = req.params.id;
        const { full_name, phone, email, housing, street, postal_code, idMunicipality_Customer } = req.body;
        const customer = await Customer.findByPk( id );
        if ( !customer ) {
            return res.status(404).json({
                msg: `The customer with id ${ id } does not exist in the database.`
            });
        }

        await db.query(
            'CALL update_customer(?, ?, ?, ?, ?, ?, ?, ?, ?);', {
                replacements: [Number(id), full_name, phone, email, housing, street, Number(postal_code), Number(idMunicipality_Customer), Number(req.user.idUser)]
            }
        );
        // await customer.update( body );
        res.json({
            msg: 'Customer updated successfully'
        });
    } catch (error) {
        console.log(error);
        res.status(500).json({
            msg: "Could not update customer"
        });
    }
}

/**
 * The function receives the id of the customer to be deleted from the request parameters, then it
 * searches for the customer in the database, if the customer is not found, it returns a 404 status
 * code and a message, if the customer is found, it changes the status of the customer to false, and
 * returns a message
 * @param {Request} req - Request - This is the request object that contains all the information about
 * the request that was made to the server.
 * @param {Response} res - Response - This is the response object that we will use to send back a
 * response to the client.
 * @returns The status of the customer is changed to inactive.
 */
export const deleteCustomer = async( req: Request, res: Response) => {
    try {
        const { id } = req.params;
        
        const customer = await Customer.findByPk( id );
        if ( !customer ) {
            return res.status(404).json({
                msg: `The customer with id ${ id } does not exist in the database.`
            });
        }
        
        await db.query(
            'CALL delete_customer(?, ?);', {
                replacements: [ Number(id), Number(req.user.idUser) ]
            }
        );
        res.json({
            msg: 'The status customer has changed to inactive'
        });
    } catch (error) {
        console.log(error);
        res.status(500).json({
            msg: 'Could not delete customer'
        });
    }

}