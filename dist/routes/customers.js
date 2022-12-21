"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
// Imports from other node packages
const express_1 = require("express");
// Imports from other this project packages
const customer_controller_1 = require("../controllers/customer.controller");
/* Creating a router object and then adding routes to it. */
const router = (0, express_1.Router)();
router.post('/', customer_controller_1.postCustomer);
router.get('/', customer_controller_1.getCustomers);
// router.get('/search', searchCustomers);
router.get('/search/:attribute', customer_controller_1.searchCustomersByAttribute);
router.get('/:id', customer_controller_1.getCustomer);
router.put('/:id', customer_controller_1.putCustomer);
router.delete('/:id', customer_controller_1.deleteCustomer);
exports.default = router;
//# sourceMappingURL=customers.js.map