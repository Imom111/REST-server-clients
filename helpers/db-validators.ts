import Customer from "../models/Customer.model";
import Municipality from "../models/Municipality.model";
import State from "../models/State.model";

export const existsCustomerByEmail = async( email: string ) => {
    const exists = await Customer.findOne({ where: { email }});
    if ( exists ) {
        throw new Error(`The email ${ email } is already registered`);
    }
    return true;
}

export const existsCustomerById = async( id: number ) => {
    const exists = await Customer.findByPk(id);
    if ( !exists ) {
        throw new Error(`The id customer id: ${ id } does not exists in the database`);
    }
    return true;
}

export const existsMuncipalityByName = async( name: string ) => {
    const exists = await Municipality.findOne({ where: { name }});
    if ( exists ) {
        throw new Error(`The municipality ${ name } is already registered`);
    }
    return true;
}

export const existsMunicipalityById = async( id: number ) => {
    const exists = await Municipality.findByPk(id);
    if ( !exists ) {
        throw new Error(`The id municipality id: ${ id } does not exists in the database`);
    }
    return true;
}

export const existsStateByName = async( name: string ) => {
    const exists = await Customer.findOne({ where: { name }});
    if ( exists ) {
        throw new Error(`The state ${ name } is already registered`);
    }
    return true;
}

export const existsStateById = async( id: number ) => {
    const exists = await State.findByPk(id);
    if ( !exists ) {
        throw new Error(`The id state id: ${ id } does not exists in the database`);
    }
    return true;
}

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