import { NextFunction, Request, Response } from 'express';

export const compareHierarchies = (req: Request, res: Response, next: NextFunction) => {
    const idRole_request = Number(req.body.idRole_User);
    const idRole_sesion = Number(req.user.idRole_User);

    if ( ( idRole_request == 1 ) && ( idRole_sesion == 2 ) ) {
        return res.status(401).json({
            msg: `No permisson for role Administrador`
        });
    } else {
        next();
    }
    
}