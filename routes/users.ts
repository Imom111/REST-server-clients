// Imports from other node packages
import { Router } from 'express';
import { check } from 'express-validator';

// Imports from other this project packages
import {
    getUser,
    getUsers,
    postUser,
    putUser,
    deleteUser,
    searchUsers,
    searchUsersByAttribute
} from '../controllers/user.controller';

import  {
    existsUserById,
    queryAttributeValidatorUser
} from "../helpers/db-validators";
import { validateJWT } from '../middlewares/jwt-validate';

import  {
    existsUserByName,
    existsUserByEmail,
    validateAll
} from "../middlewares/validateAll";

/* Creating a router object and then adding routes to it. */
const router = Router();

router.post('/', [
    validateJWT,
    validateAll,
    check('email', 'The email is not valid').isEmail(),
    existsUserByEmail,
    existsUserByName,
    validateAll
], postUser);

router.get('/', [
    validateJWT,
    validateAll
], getUsers);

router.get('/search', [
    validateJWT,
    validateAll
], searchUsers);

router.get('/search/:attribute', [
    validateJWT,
    validateAll,
    check('attribute', 'The attribute does not exists in users').custom( queryAttributeValidatorUser ),
    validateAll
], searchUsersByAttribute);

router.get('/:id', [
    validateJWT,
    validateAll,
    check('id', 'The id should be numeric').isNumeric(),
    validateAll
], getUser);

router.put('/:id', [
    validateJWT,
    validateAll,
    check('id', 'The id should be numeric').isNumeric(),
    check('id', 'The id user does not exists in the database').custom( existsUserById ),
    check('email', 'The email is not valid').isEmail(),
    existsUserByEmail,
    existsUserByName,
    validateAll
], putUser);

router.delete('/:id', [
    validateJWT,
    validateAll,
    check('id', 'The id should be numeric').isNumeric(),
    check('id', 'The id user does not exists in the database').custom( existsUserById ),
    validateAll
], deleteUser);

export default router;