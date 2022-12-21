// Imports from other node packages
import axios from "axios";
import { Request, Response } from "express";

/**
 * It receives a request with a query string, it encodes the query string and sends it to the Mapbox
 * API, then it returns the coordinates of the address
 * @param {Request} req - Request - This is the request object that contains all the information about
 * the request.
 * @param {Response} res - The response object.
 */
export const searchCoordinates = async( req: Request ,res: Response) => {
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
        const lugar = encodeURIComponent(`${ street } ${ housing } ${ postcode } ${ city } ${ state }`);

        const intance = axios.create({
            baseURL: `https://api.mapbox.com/geocoding/v5/mapbox.places/${ lugar }.json`,
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
        const { data } = await intance.get('');
        
        // The first result option is always used
        const result = data.features[0];
        
        res.json({
            lng: result.center[0],
            lat: result.center[1]
        });
    } catch (error) {
        console.log(error);
        res.status(500).json({
            msg: "It wasn't possible to get the coordinates"
        });
    }
}
