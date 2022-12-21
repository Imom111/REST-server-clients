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

import  {
    validateAll
} from "../middlewares/validateAll";

/* This is the router for the state.controller.ts file. */
const router = Router();

router.get('/', getStates);

router.get('/:id', [
    check('id', 'The id should be numeric').isNumeric(),
    check('id', 'The id state does not exists in the database').custom( existsStateById ),
    validateAll
], getState);

router.get('/search/:attribute', [
    check('attribute', 'The attribute does not exists in states').custom( queryAttributeValidatorState ),
    validateAll
], searchStatesByAttribute);

router.post('/', [
    check('name', 'This name is already registered').custom( existsStateByName ),
    validateAll
], postState);

router.put('/:id', [
    check('id', 'The id should be numeric').isNumeric(),
    check('id', 'The id state does not exists in the database').custom( existsStateById ),
    check('name', 'This name is already registered').custom( existsStateByName ),
    validateAll
], putState);

router.delete('/:id', [
    check('id', 'The id should be numeric').isNumeric(),
    check('id', 'The id state does not exists in the database').custom( existsStateById ),
    validateAll
], deleteState);

export default router;