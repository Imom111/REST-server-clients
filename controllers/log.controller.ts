// Imports from other node packages
import { Request, Response } from "express";
import { QueryTypes } from "sequelize";
import db from "../db/connection";
import { createDescriptionLog } from "../helpers/create-description-log";

export const logsAll = async( req: Request, res: Response) => {
    try {
        const log = await db.query(
            `SELECT * FROM logAll`,
            {
                type: QueryTypes.SELECT
            }
        );
        console.log(createDescriptionLog(log[0]));
        res.json({
            log
        });
    } catch (error) {
        console.log(error);
        res.status(500).json({
            msg: "Error getting logs"
        });
    }
}

export const logsCustomer = async( req: Request, res: Response) => {
    try {
        const log = await db.query(
            `SELECT * FROM logCustomer`,
            {
                type: QueryTypes.SELECT
            }
        );
        res.json({
            log
        });
    } catch (error) {
        console.log(error);
        res.status(500).json({
            msg: "Error getting customer logs"
        });
    }
}

export const logsStates = async( req: Request, res: Response) => {
    try {
        const log = await db.query(
            `SELECT * FROM logState`,
            {
                type: QueryTypes.SELECT
            }
        );
        res.json({
            log
        });
    } catch (error) {
        console.log(error);
        res.status(500).json({
            msg: "Error getting state logs"
        });
    }
}

export const logsMunicipalities = async( req: Request, res: Response) => {
    try {
        const log = await db.query(
            `SELECT * FROM logMunicipality`,
            {
                type: QueryTypes.SELECT
            }
        );
        res.json({
            log
        });
    } catch (error) {
        console.log(error);
        res.status(500).json({
            msg: "Error getting municipality logs"
        });
    }
}

export const logsUsers = async( req: Request, res: Response) => {
    try {
        const log = await db.query(
            `SELECT * FROM logUser`,
            {
                type: QueryTypes.SELECT
            }
        );
        res.json({
            log
        });
    } catch (error) {
        console.log(error);
        res.status(500).json({
            msg: "Error getting user logs"
        });
    }
}
