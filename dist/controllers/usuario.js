"use strict";
// import { Request, Response } from "express";
// import Usuario from "../models/Municipality";
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.getUsuarios = void 0;
const getUsuarios = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    const municipalities = yield Municipality.findAll();
    console.log(municipalities);
    res.json({ municipalities });
});
exports.getUsuarios = getUsuarios;
// export const getUsuario = async( req: Request, res: Response) => {
//     const { id } = req.params;
//     const usuario = await Usuario.findByPk( id );
//     if ( usuario ) {
//         res.json({
//             usuario
//         });
//     } else {
//         res.status(404).json({
//             msg: 'No existe el usuario en la base de datos'
//         });
//     }
// }
// export const postUsuario = async( req: Request, res: Response) => {
//     const { body } = req;
//     try {
//         const existeEmail = await Usuario.findOne({
//             where: {
//                 email: body.email
//             }
//         });
//         if ( existeEmail ) {
//             return res.status(400).json({
//                 msg: 'Ya existe un usuario con el email ingresado'
//             });
//         }
//         const usuario = Usuario.build( body );
//         await usuario.save();
//         res.json({
//             usuario
//         });
//     } catch (error) {
//         console.log(error);
//         res.status(500).json({
//             msg: 'Hable con el administrador'
//         });
//     }
// }
// export const putUsuario = async( req: Request, res: Response) => {
//     const { id } = req.params;
//     const { body } = req;
//     try {
//         const usuario = await Usuario.findByPk( id );
//         if ( !usuario ) {
//             return res.status(400).json({
//                 msg: 'No existe un usuario con este id'
//             });
//         }
//         // validar si se quiere actualizar solo ciertos campos
//         await usuario.update( body );
//         res.json({
//             usuario
//         });
//     } catch (error) {
//         console.log(error);
//         res.status(500).json({
//             msg: 'Hable con el administrador'
//         });
//     }
// }
// export const deleteUsuario = async( req: Request, res: Response) => {
//     const { id } = req.params;
//     try {
//         const usuario = await Usuario.findByPk( id );
//         if ( !usuario ) {
//             return res.status(400).json({
//                 msg: 'No existe un usuario con este id'
//             });
//         }
//         await usuario.destroy();
//         res.json({
//             msg: 'Usuario borrado fisicamente'
//         });
//         // await usuario.update({ estado: false });
//         // res.json({
//         //     msg: 'Usuario eliminado logicamente'
//         // });
//     } catch (error) {
//         console.log(error);
//         res.status(500).json({
//             msg: 'Hable con el administrador'
//         });
//     }
// }
//# sourceMappingURL=usuario.js.map