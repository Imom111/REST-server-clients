// Imports from other node packages
import { Router } from 'express';
import { check } from "express-validator";

// Imports from other this project packages
import {
    searchCoordinates
} from '../controllers/coordinate.controller';
import { validateJWT } from '../middlewares/jwt-validate';
import { validateAll } from '../middlewares/validateAll';

/* This is a router. It is a middleware that is used to handle HTTP requests. */
const router = Router();

router.get('/', [
    validateJWT,
    validateAll
], searchCoordinates);

export default router;