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
        const { idUser } = jwt.verify( String(token), process.env.SECRETORPRIVATEKEY || '' );
        
        const user = await User.findByPk( Number(idUser) );

        if ( !user ) {
            return res.status(401).json({
                msg: 'User not found'
            });
        }
        
        if ( !user.dataValues.status ) {
            return res.status(401).json({
                msg: 'User not active'
            }); 
        }
        req.user = user.dataValues;

        next();
    } catch (error) {
        console.log(error);
        return res.status(401).json({
            msg: `Invalid token`
        });
    }
}
