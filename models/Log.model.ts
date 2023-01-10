import { DataTypes } from 'sequelize';
import db from '../db/connection';
import User from './User.model';

const Log = db.define( 'Log',
{
	idLog: {
		type: DataTypes.INTEGER,
		autoIncrement: true,
		primaryKey: true
	},
	description: {
		type: DataTypes.STRING,
		allowNull: false
	},
	date: {
		type: DataTypes.DATE,
		allowNull: false
	},
	idUser_Log: {
        type: DataTypes.INTEGER,
		references: {
			model: User,
			key: 'idUser'
		},
		allowNull: false
    }
},
{
	tableName: 'log',
	timestamps: false,
	createdAt: false
});

export default Log;
