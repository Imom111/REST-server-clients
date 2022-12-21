/* Importing the DataTypes and the connection to the database. */
import { DataTypes } from 'sequelize';
import db from '../db/connection';

/* Creating a table in the database. */
const State = db.define( 'State',
{
	idState: {
		type: DataTypes.INTEGER,
		autoIncrement: true,
		primaryKey: true
	},
	name: {
		type: DataTypes.STRING,
		allowNull: false
	},
	status: {
		type: DataTypes.BOOLEAN,
		defaultValue: true
	}
},
{
	tableName: 'state',
	timestamps: false,
	createdAt: false
});

export default State;
