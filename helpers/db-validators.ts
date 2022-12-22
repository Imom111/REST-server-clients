import Customer from "../models/Customer.model";
import Municipality from "../models/Municipality.model";
import State from "../models/State.model";

/**
 * It checks if a customer with the given email exists in the database
 * @param {string} email - string - The email to check
 * @returns A boolean value
 */
export const existsCustomerByEmail = async( email: string ) => {
    const exists = await Customer.findOne({ where: { email }});
    if ( exists ) {
        throw new Error(`The email ${ email } is already registered`);
    }
    return true;
}

/**
 * It checks if a customer exists in the database by its id
 * @param {number} id - number - The id of the customer to check if it exists in the database.
 * @returns A boolean value
 */
export const existsCustomerById = async( id: number ) => {
    const exists = await Customer.findByPk(id);
    if ( !exists ) {
        throw new Error(`The id customer id: ${ id } does not exists in the database`);
    }
    return true;
}

/**
 * It checks if a municipality with the given name already exists in the database
 * @param {string} name - The name of the municipality
 * @returns A boolean value
 */
export const existsMuncipalityByName = async( name: string ) => {
    const exists = await Municipality.findOne({ where: { name }});
    if ( exists ) {
        throw new Error(`The municipality ${ name } is already registered`);
    }
    return true;
}

/**
 * It checks if a municipality exists in the database by its id
 * @param {number} id - number - The id of the municipality to check if it exists in the database.
 * @returns A boolean value
 */
export const existsMunicipalityById = async( id: number ) => {
    const exists = await Municipality.findByPk(id);
    if ( !exists ) {
        throw new Error(`The id municipality id: ${ id } does not exists in the database`);
    }
    return true;
}

/**
 * It checks if a state with the same name already exists in the database
 * @param {string} name - string - The name of the state
 * @returns A boolean value
 */
export const existsStateByName = async( name: string ) => {
    const exists = await State.findOne({ where: { name }});
    if ( exists ) {
        throw new Error(`The state ${ name } is already registered`);
    }
    return true;
}

/**
 * It returns true if the state with the given id exists in the database
 * @param {number} id - number - The id of the state that we want to check if it exists in the
 * database.
 * @returns A boolean value
 */
export const existsStateById = async( id: number ) => {
    const exists = await State.findByPk(id);
    if ( !exists ) {
        throw new Error(`The id state id: ${ id } does not exists in the database`);
    }
    return true;
}

/**
 * It validates that the attribute that the user wants to query exists in the database
 * @param {string} attribute - The attribute that you want to validate.
 * @returns A function that validates if the attribute exists in the database.
 */
export const queryAttributeValidatorCustomer = ( attribute: string ) => {
    const attributes: string[] = [
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
    const include = attributes.includes( attribute );
    if ( !include ) {
        throw new Error(`The attribute ${ attribute } does not exists in the database`);
    }
    return true;
}

/**
 * The function takes an attribute as a parameter and checks if it exists in the database
 * @param {string} attribute - The attribute that you want to validate.
 * @returns A function that takes an attribute as a parameter and returns a boolean.
 */
export const queryAttributeValidatorState = ( attribute: string ) => {
    const attributes: string[] = [
        'idState',
        'name'
    ];
    const include = attributes.includes( attribute );
    if ( !include ) {
        throw new Error(`The attribute ${ attribute } does not exists in the database`);
    }
    return true;
}

/**
 * It validates that the attribute passed as a parameter is a valid attribute of the Municipality table
 * @param {string} attribute - The attribute that you want to validate.
 * @returns A function that validates the attribute
 */
export const queryAttributeValidatorMunicipality = ( attribute: string ) => {
    const attributes: string[] = [
        'idMunicipality',
        'name',
        'idState_Municipality'
    ];
    const include = attributes.includes( attribute );
    if ( !include ) {
        throw new Error(`The attribute ${ attribute } does not exists in the database`);
    }
    return true;
}