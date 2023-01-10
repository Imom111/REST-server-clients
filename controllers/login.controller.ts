// Imports from other node packages
import { Request, Response } from "express";

export const logIn = async( req: Request, res: Response) => {
    try {
        const { user, password } = req.body;
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
