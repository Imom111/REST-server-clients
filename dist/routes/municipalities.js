"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
// Imports from other node packages
const express_1 = require("express");
const express_validator_1 = require("express-validator");
// Imports from other this project packages
const municipaly_controller_1 = require("../controllers/municipaly.controller");
const db_validators_1 = require("../helpers/db-validators");
const validateAll_1 = require("../middlewares/validateAll");
/* Creating a router object and then adding routes to it. */
const router = (0, express_1.Router)();
router.get('/', municipaly_controller_1.getMunicipalities);
router.get('/:id', [
    (0, express_validator_1.check)('id', 'The id should be numeric').isNumeric(),
    (0, express_validator_1.check)('id', 'The id municipality does not exists in the database').custom(db_validators_1.existsMunicipalityById),
    validateAll_1.validateAll
], municipaly_controller_1.getMunicipality);
router.get('/byEstado/:id', [
    (0, express_validator_1.check)('id', 'The id should be numeric').isNumeric(),
    (0, express_validator_1.check)('id', 'The id state does not exists in the database').custom(db_validators_1.existsStateById),
    validateAll_1.validateAll
], municipaly_controller_1.getMunicipalitiesByState);
router.get('/search/:attribute', [
    (0, express_validator_1.check)('attribute', 'The attribute does not exists in municipalities').custom(db_validators_1.queryAttributeValidatorMunicipality),
    validateAll_1.validateAll
], municipaly_controller_1.searchMunicipalitiesByAttribute);
router.post('/', [
    (0, express_validator_1.check)('name', 'This name is already registered').custom(db_validators_1.existsMuncipalityByName),
    (0, express_validator_1.check)('idState_Municipality', 'The id state does not exists in the database').custom(db_validators_1.existsStateById),
    validateAll_1.validateAll
], municipaly_controller_1.postMunicipality);
router.put('/:id', [
    (0, express_validator_1.check)('id', 'The id should be numeric').isNumeric(),
    (0, express_validator_1.check)('id', 'The id municipality does not exists in the database').custom(db_validators_1.existsMunicipalityById),
    (0, express_validator_1.check)('name', 'This name is already registered').custom(db_validators_1.existsMuncipalityByName),
    (0, express_validator_1.check)('idState_Municipality', 'The id state does not exists in the database').custom(db_validators_1.existsStateById),
    validateAll_1.validateAll
], municipaly_controller_1.putMunicipality);
router.delete('/:id', [
    (0, express_validator_1.check)('id', 'The id should be numeric').isNumeric(),
    (0, express_validator_1.check)('id', 'The id municipality does not exists in the database').custom(db_validators_1.existsMunicipalityById),
    validateAll_1.validateAll
], municipaly_controller_1.deleteMunicipality);
exports.default = router;
//# sourceMappingURL=municipalities.js.map