import { DataTypes } from 'sequelize';
import db from '../db/connection';
import Customer from './Customer.model';
import Role from './Role.model';

const User = db.define( 'user',
{
	idUser: {
		type: DataTypes.INTEGER,
		autoIncrement: true,
		primaryKey: true
	},
	name: {
		type: DataTypes.STRING,
		allowNull: false
	},
	password: {
		type: DataTypes.STRING,
		allowNull: false
	},
    email: {
		type: DataTypes.STRING,
		allowNull: false
	},
    token: {
		type: DataTypes.STRING,
		allowNull: false
	},
	status: {
		type: DataTypes.BOOLEAN,
		defaultValue: true
	},
	idCustomer_User: {
        type: DataTypes.INTEGER,
		references: {
			model: Customer,
			key: 'idCustomer'
		},
		allowNull: false
    },
	idRole_User: {
        type: DataTypes.INTEGER,
		references: {
			model: Role,
			key: 'idRole'
		},
		allowNull: false
    }
},
{
	tableName: 'user',
	timestamps: false,
	createdAt: false
});

export default User;
