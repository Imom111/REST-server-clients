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
exports.searchCoordinates = void 0;
// Imports from other node packages
const axios_1 = __importDefault(require("axios"));
/**
 * It receives a request with a query string, it encodes the query string and sends it to the Mapbox
 * API, then it returns the coordinates of the address
 * @param {Request} req - Request - This is the request object that contains all the information about
 * the request.
 * @param {Response} res - The response object.
 */
const searchCoordinates = (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    try {
        const query = req.query;
        // The number of house improves accuracy
        // const number_house = query.numero;
        const street = query.calle;
        const housing = query.colonia;
        const postcode = query.CP;
        const city = query.municipio;
        const state = query.estado;
        // The following order is recommended for MapBox searches
        const lugar = encodeURIComponent(`${street} ${housing} ${postcode} ${city} ${state}`);
        const intance = axios_1.default.create({
            baseURL: `https://api.mapbox.com/geocoding/v5/mapbox.places/${lugar}.json`,
            params: {
                'country': 'MX',
                'access_token': process.env.MAPBOX_KEY,
                'language': 'es',
                'limit': 1
            },
            headers: {
                'Accept-Encoding': 'application/json'
            }
        });
        const { data } = yield intance.get('');
        // The first result option is always used
        const result = data.features[0];
        res.json({
            lng: result.center[0],
            lat: result.center[1]
        });
    }
    catch (error) {
        console.log(error);
        res.status(500).json({
            msg: "It wasn't possible to get the coordinates"
        });
    }
});
exports.searchCoordinates = searchCoordinates;
//# sourceMappingURL=coordinate.controller.js.map