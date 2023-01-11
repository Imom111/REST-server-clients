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

import  {
    existsUserByName,
    existsUserByEmail,
    validateAll
} from "../middlewares/validateAll";

/* Creating a router object and then adding routes to it. */
const router = Router();

router.post('/', [
    check('email', 'The email is not valid').isEmail(),
    existsUserByEmail,
    existsUserByName,
    // permisos
    validateAll
], postUser);

router.get('/', getUsers);

router.get('/search', searchUsers);

router.get('/search/:attribute', [
    check('attribute', 'The attribute does not exists in users').custom( queryAttributeValidatorUser ),
    validateAll
], searchUsersByAttribute);

router.get('/:id', [
    check('id', 'The id should be numeric').isNumeric(),
    validateAll
], getUser);

router.put('/:id', [
    check('id', 'The id should be numeric').isNumeric(),
    check('id', 'The id user does not exists in the database').custom( existsUserById ),
    check('email', 'The email is not valid').isEmail(),
    existsUserByEmail,
    existsUserByName,
    // permisos
    validateAll
], putUser);

router.delete('/:id', [
    check('id', 'The id should be numeric').isNumeric(),
    check('id', 'The id user does not exists in the database').custom( existsUserById ),
    validateAll
], deleteUser);

export default router;