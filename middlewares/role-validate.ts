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


export const validateRole = ( ...roles ) => {
    return (req: Request, res: Response, next: NextFunction) => {
        const { idUser, idRole_User } = req.user;
        const rolSelected = arrRoles[idRole_User - 1].nameRole;
        if ( !rolSelected.includes( roles )) {
            return res.status(401).json({
                msg: `No permisson for ${ rolSelected }`
            });
        }
        next();
    }
}

