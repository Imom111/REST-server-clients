// Imports from other node packages
import { Router } from 'express';

// Imports from other this project packages
import {
    getCustomer,
    getCustomers,
    postCustomer,
    putCustomer,
    deleteCustomer,
    // searchCustomers,
    searchCustomersByAttribute
} from '../controllers/customer.controller';

/* Creating a router object and then adding routes to it. */
const router = Router();

router.post('/', postCustomer);

router.get('/', getCustomers);

// router.get('/search', searchCustomers);

router.get('/search/:attribute', searchCustomersByAttribute);

router.get('/:id', getCustomer);

router.put('/:id', putCustomer);

router.delete('/:id', deleteCustomer);

export default router;