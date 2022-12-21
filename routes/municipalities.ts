import { Router } from 'express';
import {
    getMunicipality,
    getMunicipalities,
    postMunicipality,
    putMunicipality,
    deleteMunicipality,
    getMunicipalitiesByState,
    searchMunicipalitiesByAttribute
} from '../controllers/municipaly.controller';

const router = Router();

router.get('/', getMunicipalities);

router.get('/:id', getMunicipality);

router.get('/byEstado/:id', getMunicipalitiesByState);

router.get('/search/:attribute', searchMunicipalitiesByAttribute);

router.post('/', postMunicipality);

router.put('/:id', putMunicipality);

router.delete('/:id', deleteMunicipality);

export default router;