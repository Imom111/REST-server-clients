import axios from "axios";
import { Request, Response } from "express";

export const searchCoordinates = async( req: Request ,res: Response) => {
    try {
        const query = req.query;
        // const number_house = query.numero;
        const street = query.calle;
        const housing = query.colonia;
        const postcode = query.CP;
        const city = query.municipio;
        const state = query.estado;
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
