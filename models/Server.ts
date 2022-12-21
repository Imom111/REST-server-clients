// Imports from other node packages
import express, { Application } from 'express';
import cors from 'cors';
import db from '../db/connection';

// Imports from other this project packages
import municipalityRoutes from '../routes/municipalities';
import stateRoutes from '../routes/states';
import customerRoutes from '../routes/customers';
import coordinateRoutes from '../routes/coordinates';

/* It's a class that creates an Express server, connects to a MySQL database, and sets up the routes
for the API */
class Server {
    /* It's declaring the properties of the class. */
    private app: Application;
    private port: string;
    private apiPaths = {
        municipalities: '/api/municipios',
        states: '/api/estados',
        customers: '/api/clientes',
        coordinates: '/api/coordenadas'
    }

    /* It's declaring the properties of the class. */
    constructor(){
        this.app = express();
        this.port = process.env.PORT || '8081';
        
        this.dbConnection();

        this.middlewares();

        this.routes();
    };

    /**
     * The function `dbConnection()` is an asynchronous function that uses the `await` keyword to wait
     * for the `db.authenticate()` function to complete before moving on to the next line of code
     */
    async dbConnection() {
        try {
            await db.authenticate();
            console.log('Database MySQL - online');
        } catch ( err: any ) {
            console.error('Unable to connect to the database:', err );
            throw new Error( err );
        }
    }

    /**
     * We're using the `cors` middleware to allow cross-origin requests, the `express.json()`
     * middleware to parse the body of the requests, and the `express.static()` middleware to serve the
     * files in the `public` folder
     */
    middlewares() {
        // cors
        this.app.use( cors() )

        // lectura del body
        this.app.use( express.json() );

        // carpeta publica
        this.app.use( express.static('public') );
    }

    /**
     * This function is used to define the routes for the application.
     */
    routes(){
        this.app.use( this.apiPaths.municipalities, municipalityRoutes );
        this.app.use( this.apiPaths.states, stateRoutes );
        this.app.use( this.apiPaths.customers, customerRoutes );
        this.app.use( this.apiPaths.coordinates, coordinateRoutes );
    }

    /**
     * The listen() function is a method of the app object that is created by the express() function.
     * The listen() function takes two arguments: the port number and a callback function. The callback
     * function is executed when the server is ready to receive requests
     */
    listen(){
        this.app.listen( this.port, () => {
            console.log(`Server working on port ${ this.port }`);
            console.log(`http://localhost:${ this.port }/`);
        });
    }
}

export default Server;