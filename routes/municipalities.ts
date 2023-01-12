// Imports from other node packages
import { Router } from 'express';
import { check } from 'express-validator';

// Imports from other this project packages
import {
    getMunicipality,
    getMunicipalities,
    postMunicipality,
    putMunicipality,
    deleteMunicipality,
    getMunicipalitiesByState,
    searchMunicipalitiesByAttribute
} from '../controllers/municipaly.controller';

import  {
    existsMunicipalityById,
    existsStateById,
    existsMuncipalityByName,
    queryAttributeValidatorMunicipality
} from "../helpers/db-validators";
import { validateJWT } from '../middlewares/jwt-validate';

import  {
    validateAll
} from "../middlewares/validateAll";

/* Creating a router object and then adding routes to it. */
const router = Router();

router.get('/', [
    validateJWT,
    validateAll
], getMunicipalities);

router.get('/:id', [
    validateJWT,
    validateAll,
    check('id', 'The id should be numeric').isNumeric(),
    check('id', 'The id municipality does not exists in the database').custom( existsMunicipalityById ),
    validateAll
], getMunicipality);

router.get('/byEstado/:id', [
    validateJWT,
    validateAll,
    check('id', 'The id should be numeric').isNumeric(),
    check('id', 'The id state does not exists in the database').custom( existsStateById ),
    validateAll
], getMunicipalitiesByState);

router.get('/search/:attribute', [
    validateJWT,
    validateAll,
    check('attribute', 'The attribute does not exists in municipalities').custom( queryAttributeValidatorMunicipality ),
    validateAll
], searchMunicipalitiesByAttribute);

router.post('/', [
    validateJWT,
    validateAll,
    check('name', 'This name is already registered').custom( existsMuncipalityByName ),
    check('idState_Municipality', 'The id state does not exists in the database').custom( existsStateById ),
    validateAll
], postMunicipality);

router.put('/:id', [
    validateJWT,
    validateAll,
    check('id', 'The id should be numeric').isNumeric(),
    check('id', 'The id municipality does not exists in the database').custom( existsMunicipalityById ),
    check('name', 'This name is already registered').custom( existsMuncipalityByName ),
    check('idState_Municipality', 'The id state does not exists in the database').custom( existsStateById ),
    validateAll
], putMunicipality);

router.delete('/:id', [
    validateJWT,
    validateAll,
    check('id', 'The id should be numeric').isNumeric(),
    check('id', 'The id municipality does not exists in the database').custom( existsMunicipalityById ),
    validateAll
], deleteMunicipality);

export default router;