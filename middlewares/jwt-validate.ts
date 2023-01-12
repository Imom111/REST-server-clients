import { NextFunction, Request, Response } from 'express';
import jwt from 'jsonwebtoken';
import User from './../models/User.model';

export const validateJWT = async( req: Request ,res: Response, next: NextFunction ) => {
    const { token } = req.query;
    if ( !token ) {
        return res.status(401).json({
            msg: 'No se recibió token'
        });
    }
    try {
        const { uid } = jwt.verify( token, process.env.SECRETORPRIVATEKEY );
        const user = await User.findByPk( uid );

        if ( !user ) {
            return res.status(401).json({
                msg: 'Token no válido - Usuario no encontrado'
            });
        }

        if ( !user.estado ) {
            return res.status(401).json({
                msg: 'Token no válido - Usuario estado: false'
            }); 
        }

        req.user = user;
        next();
    } catch (error) {
        console.log(error);
        return res.status(401).json({
            msg: `Invalid token`
        });
    }
}
