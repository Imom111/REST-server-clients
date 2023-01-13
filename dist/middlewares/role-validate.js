"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.validateRole = void 0;
const arrRoles = [
    {
        idRole: 1,
        nameRole: 'Super administrador',
    },
    {
        idRole: 2,
        nameRole: 'Administrador',
    },
    {
        idRole: 3,
        nameRole: 'Visitador',
    }
];
const validateRole = (roles) => {
    return (req, res, next) => {
        const { idRole_User } = req.user;
        let rolSelected = '';
        arrRoles.forEach(element => {
            if (element.idRole == idRole_User) {
                rolSelected = element.nameRole;
            }
        });
        if (!roles.includes(rolSelected)) {
            return res.status(401).json({
                msg: `No permisson for ${rolSelected}`
            });
        }
        next();
    };
};
exports.validateRole = validateRole;
//# sourceMappingURL=role-validate.js.map