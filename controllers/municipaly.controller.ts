// Imports from other node packages
import { Request, Response } from "express";
import { Op } from "sequelize";

// Imports from other this project packages
import Municipality from "../models/Municipality.model";
import State from "../models/State.model";

/**
 * It gets all the municipalities from the database and returns them in a JSON response
 * @param {Request} req - Request - This is the request object that contains all the information about
 * the request that was made to the server.
 * @param {Response} res - Response: This is the response object that will be sent back to the client.
 */
export const getMunicipalities = async( req: Request ,res: Response) => {
    try {
        const municipalities = await Municipality.findAll();
        res.json({
            municipalities
        });
    } catch (error) {
        console.log(error);
        res.status(500).json({
            msg: "It wasn't possible to get the municipalities"
        });
    }
}

/**
 * It gets the municipalities associated with a state
 * @param {Request} req - Request: This is the request object that contains the request information.
 * @param {Response} res - Response: This is the response object that will be sent to the client.
 */
export const getMunicipalitiesByState = async( req: Request, res: Response) => {
    try {
        const { id } = req.params;
        const state = await State.findByPk( id );
        if ( state ) {
            const municipalities = await Municipality.findAll({
                where: {
                    idState_Municipality: id
                }
            });
            if ( municipalities ) {
                res.json({
                    municipalities
                });
            } else {
                res.status(404).json({
                    msg: `The state with id ${ id } doesn't have associated municipalities.`
                });
            }
        } else {
            res.status(404).json({
                msg: `The state with id ${ id } does not exist in the database.`
            });
        }
    } catch (error) {
        console.log(error);
        res.status(500).json({
            msg: "It wasn't possible to get the municipalities"
        });
    }
}

/**
 * It gets a municipality from the database by its id
 * @param {Request} req - Request - This is the request object that contains the request information.
 * @param {Response} res - Response: This is the response object that will be sent back to the client.
 */
export const getMunicipality = async( req: Request, res: Response) => {
    try {
        const { id } = req.params;
        const municipality = await Municipality.findByPk( id );
        if ( municipality ) {
            res.json({
                municipality
            });
        } else {
            res.status(404).json({
                msg: `The municipality with id ${ id } does not exist in the database.`
            });
        }
    } catch (error) {
        console.log(error);
        res.status(500).json({
            msg: "It wasn't possible to get the municipality"
        });
    }
}

/**
 * It searches for a municipality by a given attribute and a query
 * @param {Request} req - Request - This is the request object that contains the request information.
 * @param {Response} res - Response: This is the response object that will be sent back to the client.
 */
export const searchMunicipalitiesByAttribute = async( req: Request ,res: Response) => {
    try {
        const { attribute } = req.params;
        const { query } = req.query;
        const search_value = {[Op.like]: `%${query}%`};
        const q = Object.fromEntries( [[attribute, search_value]] );
        
        const municipality = await Municipality.findAll({
            where: q
        });
        if ( municipality ) {
            res.json({
                municipality
            });
        } else {
            res.status(404).json({
                msg: `The municipality ${ attribute }: ${ query } does not exist in the database.`
            });
        }
    } catch (error) {
        console.log(error);
        res.status(500).json({
            msg: "It wasn't possible to get the municipality"
        });
    }
}

/**
 * It receives a request and a response, and it tries to save a municipality, and if it fails, it
 * returns a 500 status code with a message
 * @param {Request} req - Request - This is the request object that contains the data sent by the
 * client.
 * @param {Response} res - Response: This is the response object that will be sent back to the client.
 * @returns A function that receives a request and a response.
 */
export const postMunicipality = async( req: Request, res: Response) => {
    try {
        const { body } = req;
        const exists = await Municipality.findOne({
            where: {
                [Op.and]: [
                    { name: body.name },
                    { idState_Municipality: body.idState_Municipality }
                ]
            }
        });
        if ( exists ) {
            return res.status(400).json({
                msg: 'This municipality already exists'
            });
        }
        const municipality = Municipality.build( body );
        await municipality.save();
        res.json({
            msg: 'Muncipality saved successfully'
        });
    } catch (error) {
        console.log(error);
        res.status(500).json({
            msg: "Failed to save municipality"
        });
    }
}

/**
 * It updates a municipality in the database
 * @param {Request} req - Request - This is the request object that contains the request information.
 * @param {Response} res - Response - This is the response object that will be sent back to the client.
 * @returns A function that takes in a request and response object.
 */
export const putMunicipality = async( req: Request, res: Response) => {
    try {
        const { id } = req.params;
        const { body } = req;
        const municipality = await Municipality.findByPk( id );
        if ( !municipality ) {
            return res.status(404).json({
                msg: `The municipality with id ${ id } does not exist in the database.`
            });
        }

        await municipality.update( body );
        res.json({
            msg: 'Municipality updated successfully'
        });
    } catch (error) {
        console.log(error);
        res.status(500).json({
            msg: "Could not update municipality"
        });
    }
}

/**
 * It deletes a municipality by changing its status to false
 * @param {Request} req - Request - This is the request object that contains the data sent from the
 * client.
 * @param {Response} res - Response: This is the response object that we will use to send a response
 * back to the client.
 * @returns The status of the municipality is being changed to inactive.
 */
export const deleteMunicipality = async( req: Request, res: Response) => {
    try {
        const { id } = req.params;
        const municipality = await Municipality.findByPk( id );
        if ( !municipality ) {
            return res.status(404).json({
                msg: `The municipality with id ${ id } does not exist in the database.`
            });
        }
        
        await municipality.update({ status: false });
        res.json({
            msg: 'The status municipality has changed to inactive'
        });

    } catch (error) {
        console.log(error);
        res.status(500).json({
            msg: 'Could not delete municipality'
        });
    }

}