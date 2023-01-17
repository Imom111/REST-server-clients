// Imports from other node packages
import { Router } from 'express';

// Imports from other this project packages
import {
    logsAll,
    logsCustomer,
    logsStates,
    logsMunicipalities,
    logsUsers,
    searchLogs,
    logsLogins
} from '../controllers/log.controller';
import { validateJWT } from '../middlewares/jwt-validate';
import { validateRole } from '../middlewares/role-validate';
import { validateAll } from '../middlewares/validateAll';


/* Creating a router object and then adding routes to it. */
const router = Router();

router.get('/', [
    validateJWT,
    validateAll,
    validateRole(['Super administrador', 'Administrador']),
    validateAll
], logsAll);

router.get('/clientes', [
    validateJWT,
    validateAll,
    validateRole(['Super administrador', 'Administrador']),
    validateAll
], logsCustomer);

router.get('/estados', [
    validateJWT,
    validateAll,
    validateRole(['Super administrador', 'Administrador']),
    validateAll
], logsStates);

router.get('/municipios', [
    validateJWT,
    validateAll,
    validateRole(['Super administrador', 'Administrador']),
    validateAll
], logsMunicipalities);

router.get('/usuarios', [
    validateJWT,
    validateAll,
    validateRole(['Super administrador', 'Administrador']),
    validateAll
], logsUsers);

router.get('/login', [
    validateJWT,
    validateAll,
    validateRole(['Super administrador', 'Administrador']),
    validateAll
], logsLogins);

router.get('/search', [
    validateJWT,
    validateAll,
    validateRole(['Super administrador', 'Administrador']),
    validateAll
], searchLogs);

export default router;