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
    searchCustomers,
    searchCustomersByAttribute
} from '../controllers/customer.controller';

import  {
    existsMunicipalityById,
    existsCustomerById,
    queryAttributeValidatorCustomer
} from "../helpers/db-validators";
import { validateJWT } from '../middlewares/jwt-validate';
import { validateRole } from '../middlewares/role-validate';

import  {
    existsCustomerByEmail,
    validateAll
} from "../middlewares/validateAll";

/* Creating a router object and then adding routes to it. */
const router = Router();

router.post('/', [
    validateJWT,
    validateAll,
    validateRole(['Super administrador', 'Administrador']),
    validateAll,
    check('email', 'The email is not valid').isEmail(),
    existsCustomerByEmail,
    check('postal_code', 'The postal code should be numeric').isNumeric(),
    check('idMunicipality_Customer', 'The municipality id should be numeric').isNumeric(),
    check('idMunicipality_Customer', 'Could not find municipality id').custom( existsMunicipalityById ),
    validateAll
], postCustomer);

router.get('/', [
    validateJWT,
    validateAll,
    validateRole(['Super administrador', 'Administrador', 'Visitador']),
    validateAll,
], getCustomers);

router.get('/search', [
    validateJWT,
    validateAll,
    validateRole(['Super administrador', 'Administrador', 'Visitador']),
    validateAll,
], searchCustomers);

router.get('/search/:attribute', [
    validateJWT,
    validateAll,
    validateRole(['Super administrador', 'Administrador', 'Visitador']),
    validateAll,
    check('attribute', 'The attribute does not exists in customers').custom( queryAttributeValidatorCustomer ),
    validateAll
], searchCustomersByAttribute);

router.get('/:id', [
    validateJWT,
    validateAll,
    validateRole(['Super administrador', 'Administrador', 'Visitador']),
    validateAll,
    check('id', 'The id should be numeric').isNumeric(),
    validateAll
], getCustomer);

router.put('/:id', [
    validateJWT,
    validateAll,
    validateRole(['Super administrador', 'Administrador']),
    validateAll,
    check('id', 'The id should be numeric').isNumeric(),
    check('id', 'The id customer does not exists in the database').custom( existsCustomerById ),
    check('email', 'The email is not valid').isEmail(),
    existsCustomerByEmail,
    check('postal_code', 'The postal code should be numeric').isNumeric(),
    check('idMunicipality_Customer', 'The municipality id should be numeric').isNumeric(),
    check('idMunicipality_Customer', 'Could not find municipality id').custom( existsMunicipalityById ),
    validateAll
], putCustomer);

router.delete('/:id', [
    validateJWT,
    validateAll,
    validateRole(['Super administrador', 'Administrador']),
    validateAll,
    check('id', 'The id should be numeric').isNumeric(),
    check('id', 'The id customer does not exists in the database').custom( existsCustomerById ),
    validateAll
], deleteCustomer);

export default router;