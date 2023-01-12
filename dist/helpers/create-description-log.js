"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.createDescriptionLog = void 0;
const createDescriptionLog = (log) => {
    let description = 'some';
    // const jsonValue = JSON.parse(log.value);
    // if ( log.actionLog_description == 'Inserción' ) {
    //     description += `Se insertaron los siguientes datos: `;
    //     description += Object.values(jsonValue);
    //     description += ` en la tabla ${ log.typeLog_description }`;
    // }
    // if ( log.actionLog_description == 'Actualización' ) {
    //     description += `Se actualizaron los siguientes datos: `;
    //     description += Object.keys(jsonValue);
    //     // where true
    //     description += ` en la tabla ${ log.typeLog_description }`;
    // }
    // if ( log.actionLog_description == 'ELiminación lógica' ) {
    //     description += `Se eliminó de forma lógica el siguiente registro `;
    //     description += Object.values(jsonValue);
    //     description += ` en la tabla ${ log.typeLog_description }`;
    // }
    return {
        idLog: log.idLog,
        description,
        user_name: log.name,
        date: log.date,
        action: log.actionLog_description
    };
};
exports.createDescriptionLog = createDescriptionLog;
//# sourceMappingURL=create-description-log.js.map