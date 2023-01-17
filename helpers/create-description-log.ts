
export const createDescriptionLog = ( log: descriptionLog ) => {
    let description = '';
    if ( log.actionLog_description == 'Inserción' ) {
        description += createDescriptionInsert(log.value, log.typeLog_description);
    }

    if ( log.actionLog_description == 'Actualización' ) {
        description += createDescriptionUpdate(log.value, log.typeLog_description);
    }

    if ( log.actionLog_description == 'ELiminación lógica' ) {
        description += createDescriptionDelete(log.value);
    }

    if ( !log.actionLog_description ) {
        description += createDescriptionLogin(log.value);
        return {
            idLog: log.idLog,
            description,
            user_name: log.name,
            date: log.date,
            action: log.actionLog_description
        }
    }

    description += ` en la tabla ${ log.typeLog_description }`;
    
    return {
        idLog: log.idLog,
        description,
        user_name: log.name,
        date: log.date,
        action: log.actionLog_description
    }
}

const createDescriptionInsert = (values: string, table: string) => {
    let description = '';
    description += `Se insertaron los siguientes datos: `;
    const val = JSON.parse(values);
    const arrayValues = Object.entries(val);
    description += addDescriptionForTableInsert(arrayValues, table);
    return description;
}

const createDescriptionUpdate = (values: string, table: string) => {
    let description = '';
    description += `Se actualizaron los siguientes datos: `;
    
    const val = JSON.parse(values);
    const arrayValues = Object.entries(val);
    description += addDescriptionForTableUpdate(arrayValues, table);
    return description;
}

const createDescriptionDelete = (values: string) => {
    let description = '';
    description += `Se eliminó de forma lógica el siguiente registro `;
    const val = JSON.parse(values);
    const arrayValues = Object.entries(val);
    description += arrayValues[0][1];
    return description;
}

const createDescriptionLogin = (values: string) => {
    let description = '';
    description += `Se ha iniciado sesión con el usuario `;
    const val = JSON.parse(values);
    const arrayValues = Object.entries(val);
    description += arrayValues[0][1];
    return description;
}

const addDescriptionForTableUpdate = (arrayValues, table: string) => {
    let description = '';
    for (let i = 0; i < arrayValues.length; i++) {

        if ( Object.values(arrayValues[i][1])[0] ) {
            if (i != 0) {
                description += ', ';
            }
            switch ( table ) {
                case 'customer':
                    switch (Object.keys(arrayValues[i][1])[0]) {
                        case 'full_name_customer':
                            description += 'nombre';
                            break;
                        case 'phone_customer':
                            description += 'número de teléfono';                    
                            break;
                        case 'email_customer':
                            description += 'correo electrónico';
                            break;
                        case 'housing_customer':
                            description += 'colonia';
                            break;
                        case 'street_customer':
                            description += 'calle';
                            break;
                        case 'postal_code_customer':
                            description += 'código postal';
                            break;
                        case 'idMunicipality_Customer_customer':
                            description += 'municipio';
                            break;
                        default:
                        break;
                    }
                    break;
                case 'actionLog':
                    if ( Object.values(arrayValues[i][1])[0] ) {
                        if (i != 0) {
                            description += ', ';
                        }
                        switch (Object.keys(arrayValues[i][1])[0]) {
                            case 'description_actionLog':
                                description += 'nombre';
                                break;
                            default:
                            break;
                        }
                    }
                    break;
                case 'typeLog':
                    description += `Se editó el tipo de registro`;
                    break;
                case 'municipality':
                    description += `Se editó el nombre del municipio`;
                    break;
                case 'state':
                    description += `Se editó el nombre del estado`;
                    break;
                case 'role':
                    if ( Object.values(arrayValues[i][1])[0] ) {
                        if (i != 0) {
                            description += ', ';
                        }
                        switch (Object.keys(arrayValues[i][1])[0]) {
                            case 'description_role':
                                description += 'nombre';
                                break;
                            default:
                            break;
                        }
                    }
                    break;
                case 'user':
                    switch (Object.keys(arrayValues[i][1])[0]) {
                        case 'name_user':
                            description += 'nombre de usuario';
                            break;
                        case 'password_user':
                            description += 'contraseña';                    
                            break;
                        case 'idRole_user':
                            description += 'rol';
                            break;
                        default:
                        break;
                    }
                    break;
                default:
                    break;
            }
        }
    }
    return description;    
}

const addDescriptionForTableInsert = (arrayValues, table: string) => {
    let description = '';
    switch ( table ) {
        case 'customer':
            description += `Nombre del cliente: ${ arrayValues[0][1] }`;
            break;
        case 'actionLog':
            description += `Tipo de acción: ${ arrayValues[0][1] }`;
            break;
        case 'typeLog':
            description += `Tipo de consulta: ${ arrayValues[0][1] }`;
            break;
        case 'municipality':
            description += `Nombre del municipio: ${ arrayValues[1][1] }, con estado de: ${ arrayValues[0][1] }`;
            break;
        case 'state':
            description += `Nombre del estado: ${ arrayValues[0][1] }`;
            break;
        case 'role':
            description += `Nombre del rol: ${ arrayValues[0][1] }`;
            break;
        case 'user':
            description += `nombre de usuario ${ arrayValues[0][1] }`;
            break;
        default:
            break;
    }
    return description;
}


interface descriptionLog{
    idLog: number,
    value: string,
    date: string,
    name: string,
    typeLog_description: string,
    actionLog_description: string
}

