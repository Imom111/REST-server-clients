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
// Imports from other node packages
const express_1 = __importDefault(require("express"));
const cors_1 = __importDefault(require("cors"));
const connection_1 = __importDefault(require("../db/connection"));
// Imports from other this project packages
const municipalities_1 = __importDefault(require("../routes/municipalities"));
const states_1 = __importDefault(require("../routes/states"));
const customers_1 = __importDefault(require("../routes/customers"));
const coordinates_1 = __importDefault(require("../routes/coordinates"));
const login_1 = __importDefault(require("../routes/login"));
const users_1 = __importDefault(require("../routes/users"));
const log_1 = __importDefault(require("../routes/log"));
/* It's a class that creates an Express server, connects to a MySQL database, and sets up the routes
for the API */
class Server {
    /* It's declaring the properties of the class. */
    constructor() {
        this.apiPaths = {
            municipalities: '/api/municipios',
            states: '/api/estados',
            customers: '/api/clientes',
            coordinates: '/api/coordenadas',
            login: '/api/login',
            users: '/api/usuarios',
            logs: '/api/registros'
        };
        this.app = (0, express_1.default)();
        this.port = process.env.PORT || '8081';
        this.dbConnection();
        this.middlewares();
        this.routes();
    }
    ;
    /**
     * The function `dbConnection()` is an asynchronous function that uses the `await` keyword to wait
     * for the `db.authenticate()` function to complete before moving on to the next line of code
     */
    dbConnection() {
        return __awaiter(this, void 0, void 0, function* () {
            try {
                yield connection_1.default.authenticate();
                console.log('Database MySQL - online');
            }
            catch (err) {
                console.error('Unable to connect to the database:', err);
                throw new Error(err);
            }
        });
    }
    /**
     * We're using the `cors` middleware to allow cross-origin requests, the `express.json()`
     * middleware to parse the body of the requests, and the `express.static()` middleware to serve the
     * files in the `public` folder
     */
    middlewares() {
        this.app.disable('etag');
        // cors
        this.app.use((0, cors_1.default)());
        // lectura del body
        this.app.use(express_1.default.json());
        // carpeta publica
        this.app.use(express_1.default.static('public'));
    }
    /**
     * This function is used to define the routes for the application.
     */
    routes() {
        this.app.use(this.apiPaths.municipalities, municipalities_1.default);
        this.app.use(this.apiPaths.states, states_1.default);
        this.app.use(this.apiPaths.customers, customers_1.default);
        this.app.use(this.apiPaths.coordinates, coordinates_1.default);
        this.app.use(this.apiPaths.login, login_1.default);
        this.app.use(this.apiPaths.users, users_1.default);
        this.app.use(this.apiPaths.logs, log_1.default);
    }
    /**
     * The listen() function is a method of the app object that is created by the express() function.
     * The listen() function takes two arguments: the port number and a callback function. The callback
     * function is executed when the server is ready to receive requests
     */
    listen() {
        this.app.listen(this.port, () => {
            console.log(`Server working on port ${this.port}`);
            console.log(`http://localhost:${this.port}/`);
        });
    }
}
exports.default = Server;
//# sourceMappingURL=Server.js.map