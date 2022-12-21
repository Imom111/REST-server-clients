"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
// Imports from other node packages
const express_1 = require("express");
// Imports from other this project packages
const state_controller_1 = require("../controllers/state.controller");
/* This is the router for the state.controller.ts file. */
const router = (0, express_1.Router)();
router.get('/', state_controller_1.getStates);
router.get('/:id', state_controller_1.getState);
router.get('/search/:attribute', state_controller_1.searchStatesByAttribute);
router.post('/', state_controller_1.postState);
router.put('/:id', state_controller_1.putState);
router.delete('/:id', state_controller_1.deleteState);
exports.default = router;
//# sourceMappingURL=states.js.map