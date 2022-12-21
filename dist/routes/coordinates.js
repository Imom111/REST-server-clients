"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = require("express");
const coordinate_controller_1 = require("../controllers/coordinate.controller");
const router = (0, express_1.Router)();
router.get('/', coordinate_controller_1.searchCoordinates);
exports.default = router;
//# sourceMappingURL=coordinates.js.map