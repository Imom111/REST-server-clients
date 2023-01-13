// Imports from other node packages
import { Router } from 'express';
import { check } from 'express-validator';

// Imports from other this project packages
import {
    getState,
    getStates,
    postState,
    putState,
    deleteState,
    searchStatesByAttribute
} from '../controllers/state.controller';

import  {
    existsStateById,
    existsStateByName,
    queryAttributeValidatorState
} from "../helpers/db-validators";
import { validateJWT } from '../middlewares/jwt-validate';
import { validateRole } from '../middlewares/role-validate';

import  {
    validateAll
} from "../middlewares/validateAll";

/* This is the router for the state.controller.ts file. */
const router = Router();

router.get('/', [
    validateJWT,
    validateAll,
    validateRole(['Super administrador', 'Administrador', 'Visitador']),
    validateAll,
], getStates);

router.get('/:id', [
    validateJWT,
    validateAll,
    validateRole(['Super administrador', 'Administrador', 'Visitador']),
    validateAll,
    check('id', 'The id should be numeric').isNumeric(),
    check('id', 'The id state does not exists in the database').custom( existsStateById ),
    validateAll
], getState);

router.get('/search/:attribute', [
    validateJWT,
    validateAll,
    validateRole(['Super administrador', 'Administrador', 'Visitador']),
    validateAll,
    check('attribute', 'The attribute does not exists in states').custom( queryAttributeValidatorState ),
    validateAll
], searchStatesByAttribute);

router.post('/', [
    validateJWT,
    validateAll,
    validateRole(['Super administrador', 'Administrador']),
    validateAll,
    check('name', 'This name is already registered').custom( existsStateByName ),
    validateAll
], postState);

router.put('/:id', [
    validateJWT,
    validateAll,
    validateRole(['Super administrador', 'Administrador']),
    validateAll,
    check('id', 'The id should be numeric').isNumeric(),
    check('id', 'The id state does not exists in the database').custom( existsStateById ),
    check('name', 'This name is already registered').custom( existsStateByName ),
    validateAll
], putState);

router.delete('/:id', [
    validateJWT,
    validateAll,
    validateRole(['Super administrador', 'Administrador']),
    validateAll,
    check('id', 'The id should be numeric').isNumeric(),
    check('id', 'The id state does not exists in the database').custom( existsStateById ),
    validateAll
], deleteState);

export default router;