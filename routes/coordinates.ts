import { Router } from 'express';
import {
    searchCoordinates
} from '../controllers/coordinate.controller';

const router = Router();

router.get('/', searchCoordinates);

export default router;