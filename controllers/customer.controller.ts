import { Request, Response } from "express";
import { Op, QueryTypes } from "sequelize";

import Customer from "../models/Customer.model";

export const getCustomers = async( req: Request ,res: Response) => {
    try {
        const customers = await Customer.findAll();
        res.json({
            customers
        });   
    } catch (error) {
        console.log(error);
        res.status(500).json({
            msg: "It wasn't possible to get the customers"
        });
    }
}

export const getCustomer = async( req: Request, res: Response) => {
    try {
        const { id } = req.params;
        const customer = await Customer.findByPk( id );
        if ( customer ) {
            res.json({
                customer
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

// export const searchCustomers = async( req: Request ,res: Response) => {
//     const { query } = req.query;
//     const customers = await Customer.query(
//         'CALL login (:q)',
//         {
//             logging: console.log,
//             replacements: { q: query },
//             type: QueryTypes.SELECT
//         }
//       );
//     res.json({
//         customers
//     });
// }

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
                msg: `The customer ${ attribute }: ${ query } does not exist in the database.`
            });
        }
    } catch (error) {
        console.log(error);
        res.status(500).json({
            msg: "It wasn't possible to get the customer"
        });
    }
}

export const postCustomer = async( req: Request, res: Response) => {
    try {
        const { body } = req;
        const exists = await Customer.findOne({
            where: { full_name: body.full_name }
        });
        if ( exists ) {
            return res.status(400).json({
                msg: 'This customer already exists'
            });
        }
        const customer = Customer.build( body );
        await customer.save();
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

export const putCustomer = async( req: Request, res: Response) => {
    try {
        const { id } = req.params;
        const { body } = req;
        const customer = await Customer.findByPk( id );
        if ( !customer ) {
            return res.status(404).json({
                msg: `The customer with id ${ id } does not exist in the database.`
            });
        }

        await customer.update( body );
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

export const deleteCustomer = async( req: Request, res: Response) => {
    try {
        const { id } = req.params;
        const customer = await Customer.findByPk( id );
        if ( !customer ) {
            return res.status(404).json({
                msg: `The customer with id ${ id } does not exist in the database.`
            });
        }
        
        await customer.update({ status: false });
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