import { Sequelize } from 'sequelize';
require('dotenv').config();

const db = new Sequelize(
	process.env.DB_DATABASENAME || "",
	process.env.DB_USERNAME || "",
	process.env.DB_PASSWORD || "",
	{
		host: 'localhost',
		dialect: 'mysql',
		logging: false
	}
);

export default db;