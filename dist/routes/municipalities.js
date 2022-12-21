"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = require("express");
const municipaly_controller_1 = require("../controllers/municipaly.controller");
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