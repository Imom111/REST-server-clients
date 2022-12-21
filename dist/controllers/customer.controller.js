"use strict";
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.deleteCustomer = exports.putCustomer = exports.postCustomer = exports.searchCustomersByAttribute = exports.getCustomer = exports.getCustomers = void 0;
const sequelize_1 = require("sequelize");
// Imports from other this project packages
const Customer_model_1 = __importDefault(require("../models/Customer.model"));
/**
 * It's an async function that receives a request and a response object, and it tries to find all the
 * customers in the database, and if it succeeds, it sends a response with the customers, otherwise it
 * sends a response with an error message
 * @param {Request} req - Request - This is the request object that contains all the information about
 * the request that was made to the server.
 * @param {Response} res - Response - This is the response object that we will use to send back a
 * response to the client.
 */
const getCustomers = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const customers = yield Customer_model_1.default.findAll();
        res.json({
            customers
        });
    }
    catch (error) {
        console.log(error);
        res.status(500).json({
            msg: "It wasn't possible to get the customers"
        });
    }
});
exports.getCustomers = getCustomers;
/**
 * It gets a customer from the database by its id
 * @param {Request} req - Request - This is the request object that contains the request information.
 * @param {Response} res - Response: This is the response object that we will use to send the response
 * to the client.
 */
const getCustomer = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const { id } = req.params;
        const customer = yield Customer_model_1.default.findByPk(id);
        if (customer) {
            res.json({
                customer
            });
        }
        else {
            res.status(404).json({
                msg: `The customer with id ${id} does not exist in the database.`
            });
        }
    }
    catch (error) {
        console.log(error);
        res.status(500).json({
            msg: "It wasn't possible to get the customer"
        });
    }
});
exports.getCustomer = getCustomer;
// export const searchCustomers = async( req: Request ,res: Response) => {
//     const { query } = req.query;
//     const customers = await Customer.query(
//         'CALL login (:q)',
//         {
//             logging: console.log,
//             replacements: { q: query },
//             type: QueryTypes.SELECT
//         }
//       );
//     res.json({
//         customers
//     });
// }
/**
 * It searches for a customer by a given attribute and returns the customer if it exists
 * @param {Request} req - Request - This is the request object that contains the request information.
 * @param {Response} res - Response: This is the response object that will be sent back to the client.
 */
const searchCustomersByAttribute = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const { attribute } = req.params;
        const { query } = req.query;
        const search_value = { [sequelize_1.Op.like]: `%${query}%` };
        const q = Object.fromEntries([[attribute, search_value]]);
        const customers = yield Customer_model_1.default.findAll({
            where: q
        });
        if (customers) {
            res.json({
                customers
            });
        }
        else {
            res.status(404).json({
                msg: `The customer ${attribute}: ${query} does not exist in the database.`
            });
        }
    }
    catch (error) {
        console.log(error);
        res.status(500).json({
            msg: "It wasn't possible to get the customer"
        });
    }
});
exports.searchCustomersByAttribute = searchCustomersByAttribute;
/**
 * It receives a request and a response object, then it tries to save the customer, if it fails, it
 * returns a 500 status code with a message, if it succeeds, it returns a 200 status code with a
 * message
 * @param {Request} req - Request - This is the request object that contains the data sent from the
 * client.
 * @param {Response} res - Response - This is the response object that will be sent back to the client.
 * @returns A function that takes in a request and response object.
 */
const postCustomer = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const { body } = req;
        const exists = yield Customer_model_1.default.findOne({
            where: { full_name: body.full_name }
        });
        if (exists) {
            return res.status(400).json({
                msg: 'This customer already exists'
            });
        }
        const customer = Customer_model_1.default.build(body);
        yield customer.save();
        res.json({
            msg: 'Customer saved successfully'
        });
    }
    catch (error) {
        console.log(error);
        res.status(500).json({
            msg: "Failed to save customer"
        });
    }
});
exports.postCustomer = postCustomer;
/**
 * It updates a customer in the database
 * @param {Request} req - Request - This is the request object that contains the request information.
 * @param {Response} res - Response - This is the response object that we will use to send a response
 * back to the client.
 * @returns The customer with the id that was passed in the request params.
 */
const putCustomer = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const { id } = req.params;
        const { body } = req;
        const customer = yield Customer_model_1.default.findByPk(id);
        if (!customer) {
            return res.status(404).json({
                msg: `The customer with id ${id} does not exist in the database.`
            });
        }
        yield customer.update(body);
        res.json({
            msg: 'Customer updated successfully'
        });
    }
    catch (error) {
        console.log(error);
        res.status(500).json({
            msg: "Could not update customer"
        });
    }
});
exports.putCustomer = putCustomer;
/**
 * The function receives the id of the customer to be deleted from the request parameters, then it
 * searches for the customer in the database, if the customer is not found, it returns a 404 status
 * code and a message, if the customer is found, it changes the status of the customer to false, and
 * returns a message
 * @param {Request} req - Request - This is the request object that contains all the information about
 * the request that was made to the server.
 * @param {Response} res - Response - This is the response object that we will use to send back a
 * response to the client.
 * @returns The status of the customer is changed to inactive.
 */
const deleteCustomer = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const { id } = req.params;
        const customer = yield Customer_model_1.default.findByPk(id);
        if (!customer) {
            return res.status(404).json({
                msg: `The customer with id ${id} does not exist in the database.`
            });
        }
        yield customer.update({ status: false });
        res.json({
            msg: 'The status customer has changed to inactive'
        });
    }
    catch (error) {
        console.log(error);
        res.status(500).json({
            msg: 'Could not delete customer'
        });
    }
});
exports.deleteCustomer = deleteCustomer;
//# sourceMappingURL=customer.controller.js.map