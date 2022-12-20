import { Request, Response } from "express";

import State from "../models/State.model";

export const getStates = async( req: Request ,res: Response) => {
    const states = await State.findAll();
    res.json({
        states
    });
}

export const getState = async( req: Request, res: Response) => {
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
}

export const postState = async( req: Request, res: Response) => {
    const { body } = req;
    try {
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
            state
        });
    } catch (error) {
        console.log(error);
        res.status(500).json({
            msg: 'Server error call to administrator'
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
            state
        });
    } catch (error) {
        console.log(error);
        res.status(500).json({
            msg: 'Server error call to administrator'
        });
    }
}

export const deleteState = async( req: Request, res: Response) => {
    const { id } = req.params;
    try {
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
            msg: 'Server error call to administrator'
        });
    }

}