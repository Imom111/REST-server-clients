// Imports from other node packages
import { Router } from 'express';

// Imports from other this project packages
import {
    logsAll,
    logsCustomer,
    logsStates,
    logsMunicipalities,
    logsUsers
} from '../controllers/log.controller';


/* Creating a router object and then adding routes to it. */
const router = Router();

router.get('/', logsAll);

router.get('/clientes', logsCustomer);

router.get('/estados', logsStates);

router.get('/municipios', logsMunicipalities);

router.get('/usuarios', logsUsers);

export default router;