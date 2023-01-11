// Imports from other node packages
import { Request, Response } from "express";
import bcryptjs from 'bcryptjs';
import User from "../models/User.model";
import { generarJWT } from "../helpers/create-jwt";

export const logIn = async( req: Request, res: Response) => {
    try {
        const { user, password } = req.body;
        
        const userObj = await User.findOne({ where: { name: user } });
        if ( !userObj ) {
            return res.status(400).json({
                msg: 'User not found'
            }); 
        }

        if ( !userObj.dataValues.status ) {
            return res.status(400).json({
                msg: 'User inactive'
            }); 
        }

        // const validPassword = bcryptjs.compareSync( password, userObj.dataValues.password );
        const validPassword = password == userObj.dataValues.password;

        if ( !validPassword ) {
            return res.status(400).json({
                msg: 'User or password are not correct'
            }); 
        }
        
        const token = await generarJWT( userObj.dataValues.id );
        return res.json({
            token
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
