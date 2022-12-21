/* This is importing the Sequelize library and the dotenv library. */
import { Sequelize } from 'sequelize';
require('dotenv').config();

/* This is creating a new instance of Sequelize. */
const db = new Sequelize(
	'mysql://uf7ohogomfidsmbi:gPq0q1o0GMdql0SnLNT8@bsiyueg9lxxg8julclbi-mysql.services.clever-cloud.com:3306/bsiyueg9lxxg8julclbi'
);

export default db;