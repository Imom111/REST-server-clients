"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
// Imports from other node packages
const express_1 = require("express");
// Imports from other this project packages
const coordinate_controller_1 = require("../controllers/coordinate.controller");
const jwt_validate_1 = require("../middlewares/jwt-validate");
const role_validate_1 = require("../middlewares/role-validate");
const validateAll_1 = require("../middlewares/validateAll");
/* This is a router. It is a middleware that is used to handle HTTP requests. */
const router = (0, express_1.Router)();
router.get('/', [
    jwt_validate_1.validateJWT,
    validateAll_1.validateAll,
    (0, role_validate_1.validateRole)(['Super administrador', 'Administrador', 'Visitador']),
    validateAll_1.validateAll
], coordinate_controller_1.searchCoordinates);
exports.default = router;
//# sourceMappingURL=coordinates.js.map