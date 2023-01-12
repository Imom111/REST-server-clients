// Imports from other node packages
import { Router } from 'express';

// Imports from other this project packages
import {
    logsAll,
    logsCustomer,
    logsStates,
    logsMunicipalities,
    logsUsers,
    searchLogs
} from '../controllers/log.controller';
import { validateJWT } from '../middlewares/jwt-validate';
import { validateRole } from '../middlewares/role-validate';
import { validateAll } from '../middlewares/validateAll';


/* Creating a router object and then adding routes to it. */
const router = Router();

router.get('/', [
    validateJWT,
    validateAll
], logsAll);

router.get('/clientes', [
    validateJWT,
    validateAll,
    validateRole(['Super administrador', 'Administrador', 'Visitador']),
    validateAll
], logsCustomer);

router.get('/estados', [
    validateJWT,
    validateAll
], logsStates);

router.get('/municipios', [
    validateJWT,
    validateAll
], logsMunicipalities);

router.get('/usuarios', [
    validateJWT,
    validateAll
], logsUsers);

router.get('/search', [
    validateJWT,
    validateAll
], searchLogs);

export default router;