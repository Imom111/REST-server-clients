// Imports from other node packages
import { Request, Response } from "express";
import { Op } from "sequelize";

// Imports from other this project packages
import State from "../models/State.model";

/**
 * It's a function that receives a request and a response, and it returns a json with all the states
 * @param {Request} req - Request - This is the request object that contains all the information about
 * the request.
 * @param {Response} res - Response - This is the response object that will be sent back to the client.
 */
export const getStates = async( req: Request ,res: Response) => {
    try {
        const states = await State.findAll();
        res.json({
            states
        });
    } catch (error) {
        console.log(error);
        res.status(500).json({
            msg: "It wasn't possible to get the states"
        });
    }
}

/**
 * It gets a state from the database and returns it as a JSON object
 * @param {Request} req - Request - This is the request object that contains the request information.
 * @param {Response} res - Response: This is the response object that will be sent back to the client.
 */
export const getState = async( req: Request, res: Response) => {
    try {
        const { id } = req.params;
        const state = await State.findByPk( id );
        if ( state ) {
            res.json({
                state
            });
        } else {
            res.status(404).json({
                msg: `The state with id ${ id } does not exist in the database.`
            });
        }
    } catch (error) {
        console.log(error);
        res.status(500).json({
            msg: "It wasn't possible to get the state"
        });
    }
}

/**
 * It searches for a state by a given attribute and returns the state if it exists
 * @param {Request} req - Request - This is the request object that contains the request information.
 * @param {Response} res - Response - The response object that will be sent back to the client.
 */
export const searchStatesByAttribute = async (req: Request, res: Response) => {
    try {
        const { attribute } = req.params;
        const { query } = req.query;
        const search_value = { [Op.like]: `%${query}%` };
        const q = Object.fromEntries([[attribute, search_value]]);

        const state = await State.findAll({
            where: q
        });
        if (state) {
            res.json({
                state
            });
        } else {
            res.status(404).json({
                msg: `The state ${attribute}: ${query} does not exist in the database.`
            });
        }
    } catch (error) {
        console.log(error);
        res.status(500).json({
            msg: "It wasn't possible to get the state"
        });
    }
}

/**
 * It receives a request and a response object, and it tries to save a new state in the database
 * @param {Request} req - Request - This is the request object that contains the data sent from the
 * client.
 * @param {Response} res - Response - This is the response object that will be sent back to the client.
 * @returns A function that takes in a request and response object.
 */
export const postState = async( req: Request, res: Response) => {
    try {
        const { body } = req;
        const state = State.build( body );
        await state.save();
        res.json({
            msg: 'State saved successfully'
        });
    } catch (error) {
        console.log(error);
        res.status(500).json({
            msg: "Failed to save state"
        });
    }
}

/**
 * It updates a state in the database
 * @param {Request} req - Request - This is the request object that contains the request information.
 * @param {Response} res - Response - This is the response object that will be sent back to the client.
 * @returns The state with the id that was passed in the request params.
 */
export const putState = async( req: Request, res: Response) => {
    const { id } = req.params;
    const { body } = req;
    try {
        const state = await State.findByPk( id );
        if ( !state ) {
            return res.status(404).json({
                msg: `The state with id ${ id } does not exist in the database.`
            });
        }

        await state.update( body );
        res.json({
            msg: 'State updated successfully'
        });
    } catch (error) {
        console.log(error);
        res.status(500).json({
            msg: "Could not update state"
        });
    }
}

/**
 * It finds a state by its id, if it exists, it changes its status to false, if it doesn't exist, it
 * returns a 404 error
 * @param {Request} req - Request - This is the request object that contains the data sent from the
 * client.
 * @param {Response} res - Response: This is the response object that will be sent back to the client.
 * @returns The state with the id that was passed in the params.
 */
export const deleteState = async( req: Request, res: Response) => {
    try {
        const { id } = req.params;
        const state = await State.findByPk( id );
        if ( !state ) {
            return res.status(404).json({
                msg: `The state with id ${ id } does not exist in the database.`
            });
        }
        
        await state.update({ status: false });
        res.json({
            msg: 'The status state has changed to inactive'
        });

    } catch (error) {
        console.log(error);
        res.status(500).json({
            msg: 'Could not delete state'
        });
    }

}