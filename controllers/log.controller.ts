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
        let logFinal = [];
        for (let index = 0; index < log.length; index++) {
            logFinal.push(createDescriptionLog(log[index]));
        }
        res.json({
            resutls: logFinal
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
        let logFinal = [];
        for (let index = 0; index < log.length; index++) {
            logFinal.push(createDescriptionLog(log[index]));
        }
        res.json({
            resutls: logFinal
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
        let logFinal = [];
        for (let index = 0; index < log.length; index++) {
            logFinal.push(createDescriptionLog(log[index]));
        }
        res.json({
            resutls: logFinal
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
        let logFinal = [];
        for (let index = 0; index < log.length; index++) {
            logFinal.push(createDescriptionLog(log[index]));
        }
        res.json({
            resutls: logFinal
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
        let logFinal = [];
        for (let index = 0; index < log.length; index++) {
            logFinal.push(createDescriptionLog(log[index]));
        }
        res.json({
            resutls: logFinal
        });
    } catch (error) {
        console.log(error);
        res.status(500).json({
            msg: "Error getting user logs"
        });
    }
}

export const searchLogs = async( req: Request ,res: Response) => {
    const { query } = req.query;
    const logs = await db.query(
        `CALL searchLog ("${ query }")`,
        {
            type: QueryTypes.SELECT
        }
    );
    let logFinal = [];
    const logAll = Object.values(logs[0]);
    
    for (let index = 0; index < logAll.length; index++) {
        logFinal.push( createDescriptionLog(logAll[index]) );
    }
    res.json({
        resutls: logFinal
    });
}