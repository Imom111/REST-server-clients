// Imports from other node packages
import { Request, Response } from "express";
import { Op, QueryTypes } from "sequelize";
import bcryptjs from 'bcryptjs';
import db from "../db/connection";

// Imports from other this project packages
import User from "../models/User.model";

export const getUsers = async( req: Request ,res: Response) => {
    try {
        const users = await db.query(
            `SELECT * FROM users`,
            {
                type: QueryTypes.SELECT
            }
        );
        res.status(200).json({
            users
        });
    } catch (error) {
        console.log(error);
        res.status(500).json({
            msg: "It wasn't possible to get the users"
        });
    }
}

export const getUser = async( req: Request, res: Response) => {
    try {
        const { id } = req.params;
        const user = await User.findByPk( id );
        if ( user ) {
            res.status(200).json({
                idUser: user.dataValues.idUser,
                name: user.dataValues.name,
                password: user.dataValues.password,
                email: user.dataValues.email,
                token: user.dataValues.token,
                status: user.dataValues.status,
                idRole_User: user.dataValues.idRole_User
            });
        } else {
            res.status(404).json({
                msg: `The user with id ${ id } does not exist in the database.`
            });
        }
    } catch (error) {
        console.log(error);
        res.status(500).json({
            msg: "It wasn't possible to get the user"
        });
    }
}

export const searchUsers = async( req: Request ,res: Response) => {
    const { query } = req.query;
    const users = await db.query(
        `CALL searchUser ("${ query }")`,
        {
            type: QueryTypes.SELECT
        }
    );
    res.json({
        users: users[0]
    });
}

export const searchUsersByAttribute = async( req: Request ,res: Response) => {
    try {
        const { attribute } = req.params;
        const { query } = req.query;
        const search_value = {[Op.like]: `%${query}%`};
        const q = Object.fromEntries( [[attribute, search_value]] );
        const users = await User.findAll({
            where: q
        });
        if ( users ) {
            res.json({
                users
            });
        } else {
            res.status(404).json({
                msg: `The user with ${ attribute } equal to ${ query } does not exist in the database.`
            });
        }
    } catch (error) {
        console.log(error);
        res.status(500).json({
            msg: "It wasn't possible to get the user"
        });
    }
}

export const postUser = async( req: Request, res: Response) => {
    try {
        const { name, email, idRole_User } = req.body;
        const salt = bcryptjs.genSaltSync();
        const paswrd = bcryptjs.hashSync( req.body.password, salt );
        
        await db.query(
            'CALL insert_user(?, ?, ?, ?, ?);', {
                replacements: [name, paswrd, email, Number(idRole_User), Number(req.user.idUser)]
            }
        );

        res.json({
            msg: 'User saved successfully'
        });
    } catch (error) {
        console.log(error);
        res.status(500).json({
            msg: "Failed to save user"
        });
    }
}

export const putUser = async( req: Request, res: Response) => {
    try {
        const id = req.params.id;
        const { name, email, status, idRole_User } = req.body;
        
        const user = await User.findByPk( id );
        
        if ( !user ) {
            return res.status(404).json({
                msg: `The user with id ${ id } does not exist in the database.`
            });
        }

        const salt = bcryptjs.genSaltSync();
        const paswrd = bcryptjs.hashSync( req.body.password, salt );

        await db.query(
            'CALL update_user(?, ?, ?, ?, ?, ?, ?);', {
                replacements: [Number(id), name, paswrd, email, Boolean(status), Number(idRole_User), Number(req.user.idUser)]
            }
        );

        res.json({
            msg: 'User updated successfully'
        });

    } catch (error) {
        console.log(error);
        res.status(500).json({
            msg: "Could not update user"
        });
    }
}

export const deleteUser = async( req: Request, res: Response) => {
    try {
        const { id } = req.params;
        const user = await User.findByPk( id );
        if ( !user ) {
            return res.status(404).json({
                msg: `The user with id ${ id } does not exist in the database.`
            });
        }

        await db.query(
            'CALL delete_user(?, ?);', {
                replacements: [Number(id), Number(req.user.idUser) ]
            }
        );
        
        res.json({
            msg: 'The status user has changed to inactive'
        });
    } catch (error) {
        console.log(error);
        res.status(500).json({
            msg: 'Could not delete user'
        });
    }

}