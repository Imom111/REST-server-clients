import { Router } from 'express';
import {
    getState,
    getStates,
    postState,
    putState,
    deleteState,
    searchStatesByAttribute
} from '../controllers/state.controller';

const router = Router();

router.get('/', getStates);

router.get('/:id', getState);

router.get('/search/:attribute', searchStatesByAttribute);

router.post('/', postState);

router.put('/:id', putState);

router.delete('/:id', deleteState);

export default router;