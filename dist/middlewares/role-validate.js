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
const validateRole = (...roles) => {
    return (req, res, next) => {
        const { idUser, idRole_User } = req.user;
        const rolSelected = arrRoles[idRole_User - 1].nameRole;
        if (!rolSelected.includes(roles)) {
            return res.status(401).json({
                msg: `No permisson for ${rolSelected}`
            });
        }
        next();
    };
};
exports.validateRole = validateRole;
//# sourceMappingURL=role-validate.js.map