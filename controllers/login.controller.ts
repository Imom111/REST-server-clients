// Imports from other node packages
import { Request, Response } from "express";
import bcryptjs from 'bcryptjs';
import User from "../models/User.model";
import { generarJWT } from "../helpers/generar-jwt";

export const logIn = async( req: Request, res: Response) => {
    try {
        const { user, password } = req.body;
        
        const userObj = await User.findOne({ where: { name: user } });
        if ( !userObj ) {
            return res.status(400).json({
                msg: 'User not found'
            }); 
        }
    
        if ( !user.status ) {
            return res.status(400).json({
                msg: 'User inactive'
            }); 
        }

        const validPassword = bcryptjs.compareSync( password, user.password );
        if ( !validPassword ) {
            return res.status(400).json({
                msg: 'User or password are not correct'
            }); 
        }

        const token = await generarJWT( user.id );

        res.json({
            token
        });

        if ( user == 'admin' && password == 'admin' ) {
            return res.json({
                token: 'token'
            }); 
        } else {
            return res.status(400).json({
                msg: 'Usuario o contraseña no son correctos'
            });
        }
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
