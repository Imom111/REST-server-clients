import { DataTypes } from 'sequelize';
import db from '../db/connection';
import State from './State.model';

const Municipality = db.define( 'Municipality',
{
	idMunicipality: {
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
	},
	idState_Municipality: {
        type: DataTypes.INTEGER,
		references: {
			model: State,
			key: 'idState'
		},
		allowNull: false
    }
},
{
	tableName: 'municipality',
	timestamps: false,
	createdAt: false
});

export default Municipality;