import { Request, Response } from "express";
import { Op } from "sequelize";

import State from "../models/State.model";

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

export const searchStatesByAttribute = async( req: Request ,res: Response) => {
    try {
        const { attribute } = req.params;
        const { query } = req.query;
        const search_value = {[Op.like]: `%${query}%`};
        const q = Object.fromEntries( [[attribute, search_value]] );
        
        const state = await State.findAll({
            where: q
        });
        if ( state ) {
            res.json({
                state
            });
        } else {
            res.status(404).json({
                msg: `The state ${ attribute }: ${ query } does not exist in the database.`
            });
        }
    } catch (error) {
        console.log(error);
        res.status(500).json({
            msg: "It wasn't possible to get the state"
        });
    }
}

export const postState = async( req: Request, res: Response) => {
    try {
        const { body } = req;
        const exists = await State.findOne({
            where: { name: body.name }
        });
        if ( exists ) {
            return res.status(400).json({
                msg: 'This state already exists'
            });
        }
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