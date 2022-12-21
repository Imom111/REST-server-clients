import { Router } from 'express';
import {
    getCustomer,
    getCustomers,
    postCustomer,
    putCustomer,
    deleteCustomer,
    // searchCustomers,
    searchCustomersByAttribute
} from '../controllers/customer.controller';

const router = Router();

router.post('/', postCustomer);

router.get('/', getCustomers);

// router.get('/search', searchCustomers);

router.get('/search/:attribute', searchCustomersByAttribute);

router.get('/:id', getCustomer);

router.put('/:id', putCustomer);

router.delete('/:id', deleteCustomer);

export default router;