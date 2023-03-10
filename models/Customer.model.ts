/* Importing the DataTypes from the sequelize package, the db connection from the db/connection file,
and the Municipality model from the Municipality.model file. */
import { DataTypes } from 'sequelize';
import db from '../db/connection';
import Municipality from './Municipality.model';


/* Creating a table in the database with the name of the model. */
const Customer = db.define( 'Customer',
{
	idCustomer: {
		type: DataTypes.INTEGER,
		autoIncrement: true,
		primaryKey: true
	},
	full_name: {
		type: DataTypes.STRING,
		allowNull: false
	},
	phone: {
		type: DataTypes.STRING,
		allowNull: false
	},
	email: {
		type: DataTypes.STRING,
		allowNull: false
	},
	housing: {
		type: DataTypes.STRING,
		allowNull: false
	},
	street: {
		type: DataTypes.STRING,
		allowNull: false
	},
	postal_code: {
		type: DataTypes.INTEGER,
		allowNull: false
	},
	status: {
		type: DataTypes.BOOLEAN,
		defaultValue: true
	},
	idMunicipality_Customer: {
        type: DataTypes.INTEGER,
		references: {
			model: Municipality,
			key: 'idMunicipality'
		},
		allowNull: false
    }
},
{
	tableName: 'customer',
	timestamps: false,
	createdAt: false
});

export default Customer;
