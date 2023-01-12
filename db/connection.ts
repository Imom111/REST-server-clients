/* This is importing the Sequelize library and the dotenv library. */
import { Sequelize } from 'sequelize';
require('dotenv').config();

/* This is creating a new instance of Sequelize. */
const db = new Sequelize(
	String(process.env.DB_URI)
);

export default db;