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
const existsCustomerByEmail = (email) => __awaiter(void 0, void 0, void 0, function* () {
    const exists = yield Customer_model_1.default.findOne({ where: { email } });
    if (exists) {
        throw new Error(`The email ${email} is already registered`);
    }
    return true;
});
exports.existsCustomerByEmail = existsCustomerByEmail;
const existsCustomerById = (id) => __awaiter(void 0, void 0, void 0, function* () {
    const exists = yield Customer_model_1.default.findByPk(id);
    if (!exists) {
        throw new Error(`The id customer id: ${id} does not exists in the database`);
    }
    return true;
});
exports.existsCustomerById = existsCustomerById;
const existsMuncipalityByName = (name) => __awaiter(void 0, void 0, void 0, function* () {
    const exists = yield Municipality_model_1.default.findOne({ where: { name } });
    if (exists) {
        throw new Error(`The municipality ${name} is already registered`);
    }
    return true;
});
exports.existsMuncipalityByName = existsMuncipalityByName;
const existsMunicipalityById = (id) => __awaiter(void 0, void 0, void 0, function* () {
    const exists = yield Municipality_model_1.default.findByPk(id);
    if (!exists) {
        throw new Error(`The id municipality id: ${id} does not exists in the database`);
    }
    return true;
});
exports.existsMunicipalityById = existsMunicipalityById;
const existsStateByName = (name) => __awaiter(void 0, void 0, void 0, function* () {
    const exists = yield Customer_model_1.default.findOne({ where: { name } });
    if (exists) {
        throw new Error(`The state ${name} is already registered`);
    }
    return true;
});
exports.existsStateByName = existsStateByName;
const existsStateById = (id) => __awaiter(void 0, void 0, void 0, function* () {
    const exists = yield State_model_1.default.findByPk(id);
    if (!exists) {
        throw new Error(`The id state id: ${id} does not exists in the database`);
    }
    return true;
});
exports.existsStateById = existsStateById;
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