"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
// Imports from other node packages
const express_1 = require("express");
const express_validator_1 = require("express-validator");
// Imports from other this project packages
const state_controller_1 = require("../controllers/state.controller");
const db_validators_1 = require("../helpers/db-validators");
const validateAll_1 = require("../middlewares/validateAll");
/* This is the router for the state.controller.ts file. */
const router = (0, express_1.Router)();
router.get('/', state_controller_1.getStates);
router.get('/:id', [
    (0, express_validator_1.check)('id', 'The id should be numeric').isNumeric(),
    (0, express_validator_1.check)('id', 'The id state does not exists in the database').custom(db_validators_1.existsStateById),
    validateAll_1.validateAll
], state_controller_1.getState);
router.get('/search/:attribute', [
    (0, express_validator_1.check)('attribute', 'The attribute does not exists in states').custom(db_validators_1.queryAttributeValidatorState),
    validateAll_1.validateAll
], state_controller_1.searchStatesByAttribute);
router.post('/', [
    (0, express_validator_1.check)('name', 'This name is already registered').custom(db_validators_1.existsStateByName),
    validateAll_1.validateAll
], state_controller_1.postState);
router.put('/:id', [
    (0, express_validator_1.check)('id', 'The id should be numeric').isNumeric(),
    (0, express_validator_1.check)('id', 'The id state does not exists in the database').custom(db_validators_1.existsStateById),
    (0, express_validator_1.check)('name', 'This name is already registered').custom(db_validators_1.existsStateByName),
    validateAll_1.validateAll
], state_controller_1.putState);
router.delete('/:id', [
    (0, express_validator_1.check)('id', 'The id should be numeric').isNumeric(),
    (0, express_validator_1.check)('id', 'The id state does not exists in the database').custom(db_validators_1.existsStateById),
    validateAll_1.validateAll
], state_controller_1.deleteState);
exports.default = router;
//# sourceMappingURL=states.js.map