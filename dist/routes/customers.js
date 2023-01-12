"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
// Imports from other node packages
const express_1 = require("express");
const express_validator_1 = require("express-validator");
// Imports from other this project packages
const customer_controller_1 = require("../controllers/customer.controller");
const db_validators_1 = require("../helpers/db-validators");
const jwt_validate_1 = require("../middlewares/jwt-validate");
const validateAll_1 = require("../middlewares/validateAll");
/* Creating a router object and then adding routes to it. */
const router = (0, express_1.Router)();
router.post('/', [
    jwt_validate_1.validateJWT,
    validateAll_1.validateAll,
    (0, express_validator_1.check)('email', 'The email is not valid').isEmail(),
    validateAll_1.existsCustomerByEmail,
    (0, express_validator_1.check)('postal_code', 'The postal code should be numeric').isNumeric(),
    (0, express_validator_1.check)('idMunicipality_Customer', 'The municipality id should be numeric').isNumeric(),
    (0, express_validator_1.check)('idMunicipality_Customer', 'Could not find municipality id').custom(db_validators_1.existsMunicipalityById),
    validateAll_1.validateAll
], customer_controller_1.postCustomer);
router.get('/', [
    jwt_validate_1.validateJWT,
    validateAll_1.validateAll
], customer_controller_1.getCustomers);
router.get('/search', [
    jwt_validate_1.validateJWT,
    validateAll_1.validateAll
], customer_controller_1.searchCustomers);
router.get('/search/:attribute', [
    jwt_validate_1.validateJWT,
    validateAll_1.validateAll,
    (0, express_validator_1.check)('attribute', 'The attribute does not exists in customers').custom(db_validators_1.queryAttributeValidatorCustomer),
    validateAll_1.validateAll
], customer_controller_1.searchCustomersByAttribute);
router.get('/:id', [
    jwt_validate_1.validateJWT,
    validateAll_1.validateAll,
    (0, express_validator_1.check)('id', 'The id should be numeric').isNumeric(),
    validateAll_1.validateAll
], customer_controller_1.getCustomer);
router.put('/:id', [
    jwt_validate_1.validateJWT,
    validateAll_1.validateAll,
    (0, express_validator_1.check)('id', 'The id should be numeric').isNumeric(),
    (0, express_validator_1.check)('id', 'The id customer does not exists in the database').custom(db_validators_1.existsCustomerById),
    (0, express_validator_1.check)('email', 'The email is not valid').isEmail(),
    validateAll_1.existsCustomerByEmail,
    (0, express_validator_1.check)('postal_code', 'The postal code should be numeric').isNumeric(),
    (0, express_validator_1.check)('idMunicipality_Customer', 'The municipality id should be numeric').isNumeric(),
    (0, express_validator_1.check)('idMunicipality_Customer', 'Could not find municipality id').custom(db_validators_1.existsMunicipalityById),
    validateAll_1.validateAll
], customer_controller_1.putCustomer);
router.delete('/:id', [
    jwt_validate_1.validateJWT,
    validateAll_1.validateAll,
    (0, express_validator_1.check)('id', 'The id should be numeric').isNumeric(),
    (0, express_validator_1.check)('id', 'The id customer does not exists in the database').custom(db_validators_1.existsCustomerById),
    validateAll_1.validateAll
], customer_controller_1.deleteCustomer);
exports.default = router;
//# sourceMappingURL=customers.js.map