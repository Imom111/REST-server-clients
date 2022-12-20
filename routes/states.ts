import { Router } from 'express';
import {
    getState,
    getStates,
    postState,
    putState,
    deleteState
} from '../controllers/state.controller';

const router = Router();

router.get('/', getStates);

router.get('/:id', getState);

router.post('/', postState);

router.put('/:id', putState);

router.delete('/:id', deleteState);

export default router;