import express, { Application } from 'express';
import cors from 'cors';
import db from '../db/connection';

class Server {
    private app: Application;
    private port: string;

    constructor(){
        this.app = express();
        this.port = process.env.PORT || '8081';
        
        this.dbConnection();

        this.middlewares();
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

    listen(){
        this.app.listen( this.port, () => {
            console.log(`Server working on port ${ this.port }`);
            console.log(`http://localhost:${ this.port }/`);
        });
    }
}

export default Server;