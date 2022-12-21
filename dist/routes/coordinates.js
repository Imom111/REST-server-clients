"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
// Imports from other node packages
const express_1 = require("express");
// Imports from other this project packages
const coordinate_controller_1 = require("../controllers/coordinate.controller");
/* This is a router. It is a middleware that is used to handle HTTP requests. */
const router = (0, express_1.Router)();
router.get('/', coordinate_controller_1.searchCoordinates);
exports.default = router;
//# sourceMappingURL=coordinates.js.map