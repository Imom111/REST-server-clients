import { Router } from 'express';
import {
    getMunicipality,
    getMunicipalities,
    postMunicipality,
    putMunicipality,
    deleteMunicipality,
    getMunicipalitiesByState
} from '../controllers/municipaly.controller';

const router = Router();

router.get('/', getMunicipalities);

router.get('/:id', getMunicipality);

router.get('/byEstado/:id', getMunicipalitiesByState);

router.post('/', postMunicipality);

router.put('/:id', putMunicipality);

router.delete('/:id', deleteMunicipality);

export default router;