import { Request, Response } from "express";
import {Op} from "sequelize";

import Municipality from "../models/Municipality.model";
import State from "../models/State.model";

export const getMunicipalities = async( req: Request ,res: Response) => {
    const municipalities = await Municipality.findAll();
    res.json({
        municipalities
    });
}

export const getMunicipalitiesByState = async( req: Request, res: Response) => {
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
}

export const getMunicipality = async( req: Request, res: Response) => {
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
}

export const postMunicipality = async( req: Request, res: Response) => {
    const { body } = req;
    try {
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
            municipality
        });
    } catch (error) {
        console.log(error);
        res.status(500).json({
            msg: 'Server error call to administrator'
        });
    }
}

export const putMunicipality = async( req: Request, res: Response) => {
    const { id } = req.params;
    const { body } = req;
    try {
        const municipality = await Municipality.findByPk( id );
        if ( !municipality ) {
            return res.status(404).json({
                msg: `The municipality with id ${ id } does not exist in the database.`
            });
        }

        await municipality.update( body );
        res.json({
            municipality
        });
    } catch (error) {
        console.log(error);
        res.status(500).json({
            msg: 'Server error call to administrator'
        });
    }
}

export const deleteMunicipality = async( req: Request, res: Response) => {
    const { id } = req.params;
    try {
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
            msg: 'Server error call to administrator'
        });
    }

}