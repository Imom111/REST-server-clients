// Imports from other node packages
import { Router } from 'express';

// Imports from other this project packages
import {
    getMunicipality,
    getMunicipalities,
    postMunicipality,
    putMunicipality,
    deleteMunicipality,
    getMunicipalitiesByState,
    searchMunicipalitiesByAttribute
} from '../controllers/municipaly.controller';

/* Creating a router object and then adding routes to it. */
const router = Router();

router.get('/', getMunicipalities);

router.get('/:id', getMunicipality);

router.get('/byEstado/:id', getMunicipalitiesByState);

router.get('/search/:attribute', searchMunicipalitiesByAttribute);

router.post('/', postMunicipality);

router.put('/:id', putMunicipality);

router.delete('/:id', deleteMunicipality);

export default router;