// Imports from other node packages
import { Request, Response } from "express";
import bcryptjs from 'bcryptjs';
import User from "../models/User.model";
import { generarJWT } from "../helpers/create-jwt";
import db from "../db/connection";

export const logIn = async( req: Request, res: Response) => {
    try {
        const { user, password } = req.body;
        
        const userObj = await User.findOne({ where: { name: user } });
        if ( !userObj ) {
            return res.status(400).json({
                msg: 'User not found',
                ok: false
            }); 
        }

        if ( !userObj.dataValues.status ) {
            return res.status(400).json({
                msg: 'User inactive',
                ok: false
            }); 
        }

        const validPassword = bcryptjs.compareSync( password, userObj.dataValues.password );

        if ( !validPassword ) {
            return res.status(400).json({
                msg: 'User or password are not correct',
                ok: false
            }); 
        }
        
        await db.query(
            'CALL login(?);', {
                replacements: [Number(userObj.idUser)]
            }
        );

        const token = await generarJWT( userObj.dataValues.idUser );
        return res.json({
            token,
            idRole: userObj.idRole_User,
            ok: true
        });

    } catch (error) {
        console.log(error);
        res.status(500).json({
            msg: "Failed to login"
        });
    }
}

export const logOut = async( req: Request, res: Response) => {
    try {
        const { user } = req.body;
        console.log( user );
        res.json({
            token: 'Sesión cerrada'
        });
    } catch (error) {
        console.log(error);
        res.status(500).json({
            msg: "Failed to login"
        });
    }
}
