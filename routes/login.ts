// Imports from other node packages
import { Router } from 'express';
import { check } from 'express-validator';

// Imports from other this project packages
import {
    logIn,
    logOut
} from '../controllers/login.controller';


/* Creating a router object and then adding routes to it. */
const router = Router();

router.post('/in', logIn);

router.post('/out', logOut);

export default router;