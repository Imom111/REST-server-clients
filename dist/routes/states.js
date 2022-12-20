"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = require("express");
const state_controller_1 = require("../controllers/state.controller");
const router = (0, express_1.Router)();
router.get('/', state_controller_1.getStates);
router.get('/:id', state_controller_1.getState);
router.post('/', state_controller_1.postState);
router.put('/:id', state_controller_1.putState);
router.delete('/:id', state_controller_1.deleteState);
exports.default = router;
//# sourceMappingURL=states.js.map