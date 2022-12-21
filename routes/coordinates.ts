// Imports from other node packages
import { Router } from 'express';

// Imports from other this project packages
import {
    searchCoordinates
} from '../controllers/coordinate.controller';

/* This is a router. It is a middleware that is used to handle HTTP requests. */
const router = Router();

router.get('/', searchCoordinates);

export default router;