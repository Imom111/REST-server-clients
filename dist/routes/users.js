"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
// Imports from other node packages
const express_1 = require("express");
const express_validator_1 = require("express-validator");
// Imports from other this project packages
const user_controller_1 = require("../controllers/user.controller");
const db_validators_1 = require("../helpers/db-validators");
const jwt_validate_1 = require("../middlewares/jwt-validate");
const validateAll_1 = require("../middlewares/validateAll");
/* Creating a router object and then adding routes to it. */
const router = (0, express_1.Router)();
router.post('/', [
    jwt_validate_1.validateJWT,
    validateAll_1.validateAll,
    (0, express_validator_1.check)('email', 'The email is not valid').isEmail(),
    validateAll_1.existsUserByEmail,
    validateAll_1.existsUserByName,
    validateAll_1.validateAll
], user_controller_1.postUser);
router.get('/', [
    jwt_validate_1.validateJWT,
    validateAll_1.validateAll
], user_controller_1.getUsers);
router.get('/search', [
    jwt_validate_1.validateJWT,
    validateAll_1.validateAll
], user_controller_1.searchUsers);
router.get('/search/:attribute', [
    jwt_validate_1.validateJWT,
    validateAll_1.validateAll,
    (0, express_validator_1.check)('attribute', 'The attribute does not exists in users').custom(db_validators_1.queryAttributeValidatorUser),
    validateAll_1.validateAll
], user_controller_1.searchUsersByAttribute);
router.get('/:id', [
    jwt_validate_1.validateJWT,
    validateAll_1.validateAll,
    (0, express_validator_1.check)('id', 'The id should be numeric').isNumeric(),
    validateAll_1.validateAll
], user_controller_1.getUser);
router.put('/:id', [
    jwt_validate_1.validateJWT,
    validateAll_1.validateAll,
    (0, express_validator_1.check)('id', 'The id should be numeric').isNumeric(),
    (0, express_validator_1.check)('id', 'The id user does not exists in the database').custom(db_validators_1.existsUserById),
    (0, express_validator_1.check)('email', 'The email is not valid').isEmail(),
    validateAll_1.existsUserByEmail,
    validateAll_1.existsUserByName,
    validateAll_1.validateAll
], user_controller_1.putUser);
router.delete('/:id', [
    jwt_validate_1.validateJWT,
    validateAll_1.validateAll,
    (0, express_validator_1.check)('id', 'The id should be numeric').isNumeric(),
    (0, express_validator_1.check)('id', 'The id user does not exists in the database').custom(db_validators_1.existsUserById),
    validateAll_1.validateAll
], user_controller_1.deleteUser);
exports.default = router;
//# sourceMappingURL=users.js.map