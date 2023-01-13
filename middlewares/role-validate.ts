import { NextFunction, Request, Response } from 'express';
import User from './../models/User.model';

const arrRoles = [
    {
        idRole: 1,
        nameRole : 'Super administrador',
    },
    {
        idRole: 2,
        nameRole : 'Administrador',
    },
    {
        idRole: 3,
        nameRole : 'Visitador',
    }
]


export const validateRole = ( roles ) => {
    return (req: Request, res: Response, next: NextFunction) => {
        
        const { idRole_User } = req.user;
        let rolSelected = '';
        arrRoles.forEach(element => {
            if ( element.idRole ==  idRole_User) {
                rolSelected = element.nameRole
            }
        });
        
        if ( !roles.includes( rolSelected )) {
            return res.status(401).json({
                msg: `No permisson for ${ rolSelected }`
            });
        }
        next();
    }
}

