"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.compareHierarchies = void 0;
const compareHierarchies = (req, res, next) => {
    const idRole_request = Number(req.body.idRole_User);
    const idRole_sesion = Number(req.user.idRole_User);
    if (idRole_sesion != 1) {
        if (idRole_sesion != 2) {
            return res.status(500).json({
                msg: `Server error: Role not found`
            });
        }
        else {
            if (idRole_request == 1) {
                return res.status(401).json({
                    msg: `No permisson for role Administrador`
                });
            }
        }
    }
    next();
};
exports.compareHierarchies = compareHierarchies;
//# sourceMappingURL=validate-hierarchies.js.map