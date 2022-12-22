// Imports from other node packages
import { Router } from 'express';
import { check } from 'express-validator';

// Imports from other this project packages
import {
    getCustomer,
    getCustomers,
    postCustomer,
    putCustomer,
    deleteCustomer,
    // searchCustomers,
    searchCustomersByAttribute
} from '../controllers/customer.controller';

import  {
    existsCustomerByEmail,
    existsMunicipalityById,
    existsCustomerById,
    queryAttributeValidatorCustomer
} from "../helpers/db-validators";

import  {
    validateAll
} from "../middlewares/validateAll";

import  {
    checkEmailCustomer
} from "../middlewares/validateEmail";

/* Creating a router object and then adding routes to it. */
const router = Router();

router.post('/', [
    check('email', 'The email is not valid').isEmail(),
    check('email', 'This email is already registered').custom( existsCustomerByEmail ),
    check('postal_code', 'The postal code should be numeric').isNumeric(),
    check('idMunicipality_Customer', 'The municipality id should be numeric').isNumeric(),
    check('idMunicipality_Customer', 'Could not find municipality id').custom( existsMunicipalityById ),
    validateAll
], postCustomer);

router.get('/', getCustomers);

// router.get('/search', searchCustomers);

router.get('/search/:attribute', [
    check('attribute', 'The attribute does not exists in customers').custom( queryAttributeValidatorCustomer ),
    validateAll
], searchCustomersByAttribute);

router.get('/:id', [
    check('id', 'The id should be numeric').isNumeric(),
    validateAll
], getCustomer);

router.put('/:id', [
    check('id', 'The id should be numeric').isNumeric(),
    check('id', 'The id customer does not exists in the database').custom( existsCustomerById ),
    check('email', 'The email is not valid').isEmail(),
    checkEmailCustomer,
    check('postal_code', 'The postal code should be numeric').isNumeric(),
    check('idMunicipality_Customer', 'The municipality id should be numeric').isNumeric(),
    check('idMunicipality_Customer', 'Could not find municipality id').custom( existsMunicipalityById ),
    validateAll
], putCustomer);

router.delete('/:id', [
    check('id', 'The id should be numeric').isNumeric(),
    check('id', 'The id customer does not exists in the database').custom( existsCustomerById ),
    validateAll
], deleteCustomer);

export default router;