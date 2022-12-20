"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = require("express");
const municipaly_1 = require("../controllers/municipaly");
const router = (0, express_1.Router)();
router.get('/', municipaly_1.getMunicipalities);
router.get('/:id', municipaly_1.getMunicipality);
router.post('/', municipaly_1.postMunicipality);
router.put('/:id', municipaly_1.putMunicipality);
router.delete('/:id', municipaly_1.deleteMunicipality);
exports.default = router;
//# sourceMappingURL=customers.js.map