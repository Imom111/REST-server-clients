"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
// Imports from other node packages
const express_1 = require("express");
// Imports from other this project packages
const log_controller_1 = require("../controllers/log.controller");
const jwt_validate_1 = require("../middlewares/jwt-validate");
const role_validate_1 = require("../middlewares/role-validate");
const validateAll_1 = require("../middlewares/validateAll");
/* Creating a router object and then adding routes to it. */
const router = (0, express_1.Router)();
router.get('/', [
    jwt_validate_1.validateJWT,
    validateAll_1.validateAll,
    (0, role_validate_1.validateRole)(['Super administrador', 'Administrador']),
    validateAll_1.validateAll
], log_controller_1.logsAll);
router.get('/clientes', [
    jwt_validate_1.validateJWT,
    validateAll_1.validateAll,
    (0, role_validate_1.validateRole)(['Super administrador', 'Administrador']),
    validateAll_1.validateAll
], log_controller_1.logsCustomer);
router.get('/estados', [
    jwt_validate_1.validateJWT,
    validateAll_1.validateAll,
    (0, role_validate_1.validateRole)(['Super administrador', 'Administrador']),
    validateAll_1.validateAll
], log_controller_1.logsStates);
router.get('/municipios', [
    jwt_validate_1.validateJWT,
    validateAll_1.validateAll,
    (0, role_validate_1.validateRole)(['Super administrador', 'Administrador']),
    validateAll_1.validateAll
], log_controller_1.logsMunicipalities);
router.get('/usuarios', [
    jwt_validate_1.validateJWT,
    validateAll_1.validateAll,
    (0, role_validate_1.validateRole)(['Super administrador', 'Administrador']),
    validateAll_1.validateAll
], log_controller_1.logsUsers);
router.get('/search', [
    jwt_validate_1.validateJWT,
    validateAll_1.validateAll,
    (0, role_validate_1.validateRole)(['Super administrador', 'Administrador']),
    validateAll_1.validateAll
], log_controller_1.searchLogs);
exports.default = router;
//# sourceMappingURL=log.js.map