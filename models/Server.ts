import express, { Application } from 'express';
import cors from 'cors';
import db from '../db/connection';

import userRoutes from '../routes/municipalities';

class Server {
    private app: Application;
    private port: string;
    private apiPaths = {
        municipalities: '/api/municipios'
    }

    constructor(){
        this.app = express();
        this.port = process.env.PORT || '8081';
        
        this.dbConnection();

        this.middlewares();

        this.routes();
    };

    async dbConnection() {
        try {
            await db.authenticate();
            console.log('Database MySQL - online');
        } catch ( err: any ) {
            console.error('Unable to connect to the database:', err );
            throw new Error( err );
        }
    }

    middlewares() {
        // cors
        this.app.use( cors() )

        // lectura del body
        this.app.use( express.json() );

        // carpeta publica
        this.app.use( express.static('public') );
    }

    routes(){
        this.app.use( this.apiPaths.municipalities, userRoutes );
    }

    listen(){
        this.app.listen( this.port, () => {
            console.log(`Server working on port ${ this.port }`);
            console.log(`http://localhost:${ this.port }/`);
        });
    }
}

export default Server;