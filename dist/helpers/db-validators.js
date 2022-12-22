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
exports.queryAttributeValidatorMunicipality = exports.queryAttributeValidatorState = exports.queryAttributeValidatorCustomer = exports.existsStateById = exports.existsStateByName = exports.existsMunicipalityById = exports.existsMuncipalityByName = exports.existsCustomerById = exports.existsCustomerByEmail = void 0;
const Customer_model_1 = __importDefault(require("../models/Customer.model"));
const Municipality_model_1 = __importDefault(require("../models/Municipality.model"));
const State_model_1 = __importDefault(require("../models/State.model"));
/**
 * It checks if a customer with the given email exists in the database
 * @param {string} email - string - The email to check
 * @returns A boolean value
 */
const existsCustomerByEmail = (email) => __awaiter(void 0, void 0, void 0, function* () {
    const exists = yield Customer_model_1.default.findOne({ where: { email } });
    if (exists) {
        throw new Error(`The email ${email} is already registered`);
    }
    return true;
});
exports.existsCustomerByEmail = existsCustomerByEmail;
/**
 * It checks if a customer exists in the database by its id
 * @param {number} id - number - The id of the customer to check if it exists in the database.
 * @returns A boolean value
 */
const existsCustomerById = (id) => __awaiter(void 0, void 0, void 0, function* () {
    const exists = yield Customer_model_1.default.findByPk(id);
    if (!exists) {
        throw new Error(`The id customer id: ${id} does not exists in the database`);
    }
    return true;
});
exports.existsCustomerById = existsCustomerById;
/**
 * It checks if a municipality with the given name already exists in the database
 * @param {string} name - The name of the municipality
 * @returns A boolean value
 */
const existsMuncipalityByName = (name) => __awaiter(void 0, void 0, void 0, function* () {
    const exists = yield Municipality_model_1.default.findOne({ where: { name } });
    if (exists) {
        throw new Error(`The municipality ${name} is already registered`);
    }
    return true;
});
exports.existsMuncipalityByName = existsMuncipalityByName;
/**
 * It checks if a municipality exists in the database by its id
 * @param {number} id - number - The id of the municipality to check if it exists in the database.
 * @returns A boolean value
 */
const existsMunicipalityById = (id) => __awaiter(void 0, void 0, void 0, function* () {
    const exists = yield Municipality_model_1.default.findByPk(id);
    if (!exists) {
        throw new Error(`The id municipality id: ${id} does not exists in the database`);
    }
    return true;
});
exports.existsMunicipalityById = existsMunicipalityById;
/**
 * It checks if a state with the same name already exists in the database
 * @param {string} name - string - The name of the state
 * @returns A boolean value
 */
const existsStateByName = (name) => __awaiter(void 0, void 0, void 0, function* () {
    const exists = yield State_model_1.default.findOne({ where: { name } });
    if (exists) {
        throw new Error(`The state ${name} is already registered`);
    }
    return true;
});
exports.existsStateByName = existsStateByName;
/**
 * It returns true if the state with the given id exists in the database
 * @param {number} id - number - The id of the state that we want to check if it exists in the
 * database.
 * @returns A boolean value
 */
const existsStateById = (id) => __awaiter(void 0, void 0, void 0, function* () {
    const exists = yield State_model_1.default.findByPk(id);
    if (!exists) {
        throw new Error(`The id state id: ${id} does not exists in the database`);
    }
    return true;
});
exports.existsStateById = existsStateById;
/**
 * It validates that the attribute that the user wants to query exists in the database
 * @param {string} attribute - The attribute that you want to validate.
 * @returns A function that validates if the attribute exists in the database.
 */
const queryAttributeValidatorCustomer = (attribute) => {
    const attributes = [
        'idCustomer',
        'full_name',
        'phone',
        'email',
        'housing',
        'street',
        'postal_code',
        'status',
        'idMunicipality_Customer'
    ];
    const include = attributes.includes(attribute);
    if (!include) {
        throw new Error(`The attribute ${attribute} does not exists in the database`);
    }
    return true;
};
exports.queryAttributeValidatorCustomer = queryAttributeValidatorCustomer;
/**
 * The function takes an attribute as a parameter and checks if it exists in the database
 * @param {string} attribute - The attribute that you want to validate.
 * @returns A function that takes an attribute as a parameter and returns a boolean.
 */
const queryAttributeValidatorState = (attribute) => {
    const attributes = [
        'idState',
        'name'
    ];
    const include = attributes.includes(attribute);
    if (!include) {
        throw new Error(`The attribute ${attribute} does not exists in the database`);
    }
    return true;
};
exports.queryAttributeValidatorState = queryAttributeValidatorState;
/**
 * It validates that the attribute passed as a parameter is a valid attribute of the Municipality table
 * @param {string} attribute - The attribute that you want to validate.
 * @returns A function that validates the attribute
 */
const queryAttributeValidatorMunicipality = (attribute) => {
    const attributes = [
        'idMunicipality',
        'name',
        'idState_Municipality'
    ];
    const include = attributes.includes(attribute);
    if (!include) {
        throw new Error(`The attribute ${attribute} does not exists in the database`);
    }
    return true;
};
exports.queryAttributeValidatorMunicipality = queryAttributeValidatorMunicipality;
//# sourceMappingURL=db-validators.js.map