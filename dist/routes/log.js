"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
// Imports from other node packages
const express_1 = require("express");
// Imports from other this project packages
const log_controller_1 = require("../controllers/log.controller");
/* Creating a router object and then adding routes to it. */
const router = (0, express_1.Router)();
router.get('/', log_controller_1.logsAll);
router.get('/clientes', log_controller_1.logsCustomer);
router.get('/estados', log_controller_1.logsStates);
router.get('/municipios', log_controller_1.logsMunicipalities);
router.get('/usuarios', log_controller_1.logsUsers);
router.get('/search', log_controller_1.searchLogs);
exports.default = router;
//# sourceMappingURL=log.js.map