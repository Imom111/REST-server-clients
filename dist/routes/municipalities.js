"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
// Imports from other node packages
const express_1 = require("express");
// Imports from other this project packages
const municipaly_controller_1 = require("../controllers/municipaly.controller");
/* Creating a router object and then adding routes to it. */
const router = (0, express_1.Router)();
router.get('/', municipaly_controller_1.getMunicipalities);
router.get('/:id', municipaly_controller_1.getMunicipality);
router.get('/byEstado/:id', municipaly_controller_1.getMunicipalitiesByState);
router.get('/search/:attribute', municipaly_controller_1.searchMunicipalitiesByAttribute);
router.post('/', municipaly_controller_1.postMunicipality);
router.put('/:id', municipaly_controller_1.putMunicipality);
router.delete('/:id', municipaly_controller_1.deleteMunicipality);
exports.default = router;
//# sourceMappingURL=municipalities.js.map