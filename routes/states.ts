// Imports from other node packages
import { Router } from 'express';

// Imports from other this project packages
import {
    getState,
    getStates,
    postState,
    putState,
    deleteState,
    searchStatesByAttribute
} from '../controllers/state.controller';

/* This is the router for the state.controller.ts file. */
const router = Router();

router.get('/', getStates);

router.get('/:id', getState);

router.get('/search/:attribute', searchStatesByAttribute);

router.post('/', postState);

router.put('/:id', putState);

router.delete('/:id', deleteState);

export default router;