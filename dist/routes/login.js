"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
// Imports from other node packages
const express_1 = require("express");
// Imports from other this project packages
const login_controller_1 = require("../controllers/login.controller");
/* Creating a router object and then adding routes to it. */
const router = (0, express_1.Router)();
router.post('/in', login_controller_1.logIn);
router.post('/out', login_controller_1.logOut);
exports.default = router;
//# sourceMappingURL=login.js.map