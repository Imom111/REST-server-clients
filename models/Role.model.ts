import { DataTypes } from 'sequelize';
import db from '../db/connection';

const Role = db.define( 'Role',
{
	idRole: {
		type: DataTypes.INTEGER,
		autoIncrement: true,
		primaryKey: true
	},
	name: {
		type: DataTypes.STRING,
		allowNull: false
	}
},
{
	tableName: 'role',
	timestamps: false,
	createdAt: false
});

export default Role;
