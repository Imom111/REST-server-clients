DROP DATABASE IF EXISTS customer_test;
CREATE DATABASE customer_test;
USE customer_test;

SELECT * FROM log WHERE idTypeLog_Log = 1 ORDER BY date DESC;
SELECT * FROM user;

CREATE TABLE state (
    idState INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    status BOOLEAN DEFAULT TRUE
);

CREATE TABLE municipality(
	idMunicipality INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    status BOOLEAN DEFAULT true,
    idState_Municipality INT NOT NULL,
    FOREIGN KEY (idstate_Municipality) REFERENCES state(idState)
);

CREATE TABLE role(
	idRole INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL
);

CREATE TABLE user(
	idUser INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
	password VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    token VARCHAR(255) DEFAULT NULL,
    status BOOLEAN DEFAULT true,
	idRole_User INT NOT NULL,
    FOREIGN KEY (idRole_User) REFERENCES role(idRole)
);

CREATE TABLE customer(
	idCustomer INT PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(255) NOT NULL,
    phone VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    housing VARCHAR(255) NOT NULL,
    street VARCHAR(255) NOT NULL,
    postal_code INT NOT NULL,
    status BOOLEAN DEFAULT true,
    idMunicipality_Customer INT NOT NULL,
    FOREIGN KEY (idMunicipality_Customer) REFERENCES municipality(idMunicipality)
);

CREATE TABLE actionLog(
	idActionLog INT PRIMARY KEY AUTO_INCREMENT,
    description VARCHAR(1023) NOT NULL
);

CREATE TABLE typeLog(
	idTypeLog INT PRIMARY KEY AUTO_INCREMENT,
    description VARCHAR(1023) NOT NULL
);

CREATE TABLE log(
	idLog INT PRIMARY KEY AUTO_INCREMENT,
    value VARCHAR(1023) NOT NULL,
	date TIMESTAMP NOT NULL,
    idTypeLog_Log INT NOT NULL,
    FOREIGN KEY (idTypeLog_Log) REFERENCES typeLog(idTypeLog),
    idTypeAction_Log INT NOT NULL,
    FOREIGN KEY (idTypeAction_Log) REFERENCES actionLog(idActionLog),
	idUser_Log INT NOT NULL,
    FOREIGN KEY (idUser_Log) REFERENCES user(idUser)
);

DELIMITER //
CREATE PROCEDURE searchCustomer( IN param VARCHAR(255) )
BEGIN
	SELECT * FROM customer WHERE
	idCustomer LIKE CONCAT( '%', param,'%') OR
	full_name LIKE CONCAT( '%', param,'%') OR
	phone LIKE CONCAT( '%', param,'%') OR
	email LIKE CONCAT( '%', param,'%') OR
	housing LIKE CONCAT( '%', param,'%') OR
	street LIKE CONCAT( '%', param,'%') OR
	postal_code LIKE CONCAT( '%', param,'%') OR
	status LIKE CONCAT( '%', param,'%') OR
	idMunicipality_Customer LIKE CONCAT( '%', param,'%');
END
// DELIMITER ;


DELIMITER //
CREATE PROCEDURE searchUser( IN param VARCHAR(255) )
BEGIN
	SELECT * FROM user WHERE
	idUser LIKE CONCAT( '%', param,'%') OR
    name LIKE CONCAT( '%', param,'%') OR
	email LIKE CONCAT( '%', param,'%') OR
	status LIKE CONCAT( '%', param,'%') OR
	idRole_User LIKE CONCAT( '%', param,'%');
END
// DELIMITER ;

-- ***************************************** --
-- ********* System initialization ********* --
-- ***************************************** --

INSERT INTO role(name) VALUES ('Super administrador');
INSERT INTO user(name, password, email, idRole_User) VALUES('admin', 'admin', 'admin@gmail.com', 1);

INSERT INTO actionLog ( description ) VALUES ( 'Inserción' );
INSERT INTO actionLog ( description ) VALUES ( 'Actualización' );
INSERT INTO actionLog ( description ) VALUES ( 'ELiminación lógica' );
INSERT INTO actionLog ( description ) VALUES ( 'ELiminación física' );

INSERT INTO typeLog ( description ) VALUES ( 'user' );
INSERT INTO typeLog ( description ) VALUES ( 'role' );
INSERT INTO typeLog ( description ) VALUES ( 'state' );
INSERT INTO typeLog ( description ) VALUES ( 'municipality' );
INSERT INTO typeLog ( description ) VALUES ( 'customer' );
INSERT INTO typeLog ( description ) VALUES ( 'actionLog' );
INSERT INTO typeLog ( description ) VALUES ( 'typeLog' );

INSERT INTO log ( value, date, idTypeLog_Log, idTypeAction_Log, idUser_Log )
	VALUES( JSON_OBJECT('name_role', 'Super administrador'), NOW(), 2, 1, 1 );

INSERT INTO log ( value, date, idTypeLog_Log, idTypeAction_Log, idUser_Log )
	VALUES( JSON_OBJECT('name_user', 'admin'), NOW(), 1, 1, 1 );

INSERT INTO log ( value, date, idTypeLog_Log, idTypeAction_Log, idUser_Log )
	VALUES( JSON_OBJECT('description_actionLog', 'Inserción'), NOW(), 6, 1, 1 );
INSERT INTO log ( value, date, idTypeLog_Log, idTypeAction_Log, idUser_Log )
	VALUES( JSON_OBJECT('description_actionLog', 'Actualización'), NOW(), 6, 1, 1 );
INSERT INTO log ( value, date, idTypeLog_Log, idTypeAction_Log, idUser_Log )
	VALUES( JSON_OBJECT('description_actionLog', 'ELiminación lógica'), NOW(), 6, 1, 1 );
INSERT INTO log ( value, date, idTypeLog_Log, idTypeAction_Log, idUser_Log )
	VALUES( JSON_OBJECT('description_actionLog', 'ELiminación física'), NOW(), 6, 1, 1 );

INSERT INTO log ( value, date, idTypeLog_Log, idTypeAction_Log, idUser_Log )
	VALUES( JSON_OBJECT('description_typeLog', 'user'), NOW(), 7, 1, 1 );
INSERT INTO log ( value, date, idTypeLog_Log, idTypeAction_Log, idUser_Log )
	VALUES( JSON_OBJECT('description_typeLog', 'role'), NOW(), 7, 1, 1 );
INSERT INTO log ( value, date, idTypeLog_Log, idTypeAction_Log, idUser_Log )
	VALUES( JSON_OBJECT('description_typeLog', 'state'), NOW(), 7, 1, 1 );
INSERT INTO log ( value, date, idTypeLog_Log, idTypeAction_Log, idUser_Log )
	VALUES( JSON_OBJECT('description_typeLog', 'municipality'), NOW(), 7, 1, 1 );
INSERT INTO log ( value, date, idTypeLog_Log, idTypeAction_Log, idUser_Log )
	VALUES( JSON_OBJECT('description_typeLog', 'customer'), NOW(), 7, 1, 1 );
INSERT INTO log ( value, date, idTypeLog_Log, idTypeAction_Log, idUser_Log )
	VALUES( JSON_OBJECT('description_typeLog', 'actionLog'), NOW(), 7, 1, 1 );
INSERT INTO log ( value, date, idTypeLog_Log, idTypeAction_Log, idUser_Log )
	VALUES( JSON_OBJECT('description_typeLog', 'typeLog'), NOW(), 7, 1, 1 );

-- ***************************************** --
-- *************** actionLog *************** --
-- ***************************************** --

DELIMITER //
CREATE PROCEDURE insert_actionLog( IN var_description_actionLog VARCHAR(255),
								   IN var_id_user INT )
BEGIN
	INSERT INTO actionLog ( description ) VALUES (var_description_actionLog);
	INSERT INTO log ( value, date, idTypeLog_Log, idTypeAction_Log, idUser_Log ) VALUES(JSON_OBJECT('description_actionLog', var_description_actionLog), NOW(), 6, 1, var_id_user);
END
// DELIMITER ;
-- CALL insert_actionLog('[Some action description]', [some idUser]);

DELIMITER //
CREATE PROCEDURE update_actionLog( IN var_description_actionLog VARCHAR(255),
								   IN var_id_actionLog INT,
								   IN var_id_user INT )
BEGIN
	UPDATE actionLog SET description = var_description_actionLog WHERE idActionLog = var_id_actionLog;
	INSERT INTO log ( value, date, idTypeLog_Log, idTypeAction_Log, idUser_Log ) VALUES(JSON_OBJECT('description_actionLog', var_description_actionLog), NOW(), 6, 2, var_id_user);
END
// DELIMITER ;
-- CALL update_actionLog('[Some action description]', [some idActionLog], [some idUser]);

-- ***************************************** --
-- ****************** role ***************** --
-- ***************************************** --

DELIMITER //
CREATE PROCEDURE insert_role( IN var_name_role VARCHAR(255),
							  IN var_id_user INT )
BEGIN
	INSERT INTO role ( name ) VALUES (var_name_role);
	INSERT INTO log ( value, date, idTypeLog_Log, idTypeAction_Log, idUser_Log ) VALUES(JSON_OBJECT('name_role', var_name_role), NOW(), 2, 1, var_id_user);
END
// DELIMITER ;

-- CALL update_role('[Some role description]', [some idUser]);
CALL insert_role ('Administrador', 1);
CALL insert_role ('Visitador', 1);

DELIMITER //
CREATE PROCEDURE update_role( IN var_description_actionLog VARCHAR(255),
								   IN var_id_role INT,
								   IN var_id_user INT )
BEGIN
	UPDATE actionLog SET description = var_description_actionLog WHERE idRole = var_id_role;
	INSERT INTO log ( value, date, idTypeLog_Log, idTypeAction_Log, idUser_Log ) VALUES(JSON_OBJECT('description_actionLog', var_description_actionLog), NOW(), 2, 2, var_id_user);
END
// DELIMITER ;

-- CALL update_role('[Some role description]', [some idRole], [some idUser]);

-- ***************************************** --
-- ****************** user ***************** --
-- ***************************************** --

DELIMITER //
CREATE PROCEDURE insert_user( IN var_name VARCHAR(255),
							  IN var_password VARCHAR(255),
							  IN var_email VARCHAR(255),
							  IN var_idRole_User INT,
							  IN var_id_user INT )
BEGIN
	INSERT INTO user ( name, password, email, idRole_User )
		VALUES ( var_name, var_password, var_email, var_idRole_User );
	INSERT INTO log ( value, date, idTypeLog_Log, idTypeAction_Log, idUser_Log ) VALUES(JSON_OBJECT('name_user', var_name), NOW(), 1, 1, var_id_user);
END
// DELIMITER ;

-- CALL insert_user('[Some user name]', '[Some user password]', '[Some user email]', [Some idRole], [some idUser]);
CALL insert_user('Ivan123', '123', 'ivan123@gmail.com', 2, 1);
CALL insert_user('Pureco123', '123', 'pureco123@gmail.com', 2, 1);
CALL insert_user('Adrian123', '123', 'adrian123@gmail.com', 2, 1);
CALL insert_user('Mau123', '123', 'mau123@gmail.com', 3, 1);
CALL insert_user('Axel123', '123', 'axel123@gmail.com', 3, 1);
CALL insert_user('Brenda123', '123', 'brenda123@gmail.com', 3, 1);

DELIMITER //
CREATE PROCEDURE delete_user( IN var_idUser INT,
							  IN var_id_user INT )
BEGIN
	UPDATE user SET
		status = FALSE, 
		token = NULL
	WHERE idUser = var_idUser;
    SET @username = (SELECT name FROM user WHERE idUser = var_idUser);
    INSERT INTO log ( value, date, idTypeLog_Log, idTypeAction_Log, idUser_Log ) VALUES(JSON_OBJECT('name_user', @username), NOW(), 1, 3, var_id_user);
END
// DELIMITER ;

-- CALL delete_user([Some idUser], [Some idUser]);

DELIMITER //
CREATE PROCEDURE update_user( IN var_idUser INT,
								   IN var_name VARCHAR(255),
								   IN var_password VARCHAR(255),
								   IN var_email VARCHAR(255),
								   IN var_status BOOLEAN,
								   IN var_idRole_User INT,
								   IN var_id_user INT )
BEGIN	
    SET @var_json_final = '[';
    IF var_name != (SELECT name FROM user WHERE idUser = var_idUser) THEN 
	   SET @var_json_final = CONCAT(@var_json_final, JSON_OBJECT('name_user', true));
	END IF;
    
    IF var_password != (SELECT password FROM user WHERE idUser = var_idUser) THEN 
	   SET @var_json_final = CONCAT(@var_json_final,
			IF(@var_json_final != '[' ,',', ''),
            JSON_OBJECT('password_user', true));
	END IF;
    
    IF var_email != (SELECT email FROM user WHERE idUser = var_idUser) THEN 
	   SET @var_json_final = CONCAT(@var_json_final,
			IF(@var_json_final != '[' ,',', ''),
            JSON_OBJECT('email_user', true));
	END IF;
    
    IF var_status != (SELECT status FROM user WHERE idUser = var_idUser) THEN 
	   SET @var_json_final = CONCAT(@var_json_final,
			IF(@var_json_final != '[' ,',', ''),
            JSON_OBJECT('status_user', true));
	END IF;
    
    IF var_idRole_User != (SELECT idRole_User FROM user WHERE idUser = var_idUser) THEN 
	   SET @var_json_final = CONCAT(@var_json_final,
			IF(@var_json_final != '[' ,',', ''),
            JSON_OBJECT('idRole_user', true));
	END IF;
    
    SET @var_json_final = CONCAT(@var_json_final, ']');
	UPDATE user SET
		name = var_name,
		password = var_password,
        email = var_email,
        status = var_status,
        idRole_User = var_idRole_User
		WHERE idUser = var_idUser;
    INSERT INTO log ( value, date, idTypeLog_Log, idTypeAction_Log, idUser_Log ) VALUES(@var_json_final, NOW(), 1, 2, var_id_user);
END
// DELIMITER ;

-- CALL update_user([Some idUser], '[Some user name]', '[Some user password]', '[Some user email]', [Some idRole], [some idUser]);
CALL update_user(2, 'Ivan1234', '1234', 'ivan123@gmail.com', true, 1, 1);


-- ***************************************** --
-- ************** municipality ************* --
-- ***************************************** --

DELIMITER //
CREATE PROCEDURE insert_municipality( IN var_name_municipality VARCHAR(255),
									 IN var_id_state INT,
									 IN var_id_user INT )
BEGIN
	INSERT INTO municipality (name, idstate_municipality) VALUES (var_name_municipality, var_id_state);
    SET @nameState = (SELECT name FROM state WHERE idState = var_id_state);
	INSERT INTO log (value, date, idTypeLog_Log, idTypeAction_Log, idUser_Log) VALUES(JSON_OBJECT('name_municipality', var_name_municipality, 'name_state', @nameState), NOW(), 4, 1, var_id_user);
END
// DELIMITER ;

-- CALL insert_municipality('[Some municipality name]', [Some idState], [some idUser]);

-- ***************************************** --
-- ***************** state ***************** --
-- ***************************************** --

DELIMITER //
CREATE PROCEDURE insert_state( IN var_name_state VARCHAR(255),
							   IN var_id_user INT )
BEGIN
	INSERT INTO state ( name ) VALUES ( var_name_state );
    INSERT INTO log (value, date, idTypeLog_Log, idTypeAction_Log, idUser_Log) VALUES(JSON_OBJECT('name_state', var_name_state ), NOW(), 4, 1, var_id_user);
END
// DELIMITER ;

-- CALL insert_state('[Some state name]', [Some idUser]);



CALL insert_state('AGUASCALIENTES', 1);
CALL insert_municipality('AGUASCALIENTES', 1, 1);
CALL insert_municipality('ASIENTOS', 1, 1);
CALL insert_municipality('CALVILLO', 1, 1);
CALL insert_municipality('COSÍO', 1, 1);
CALL insert_municipality('JESÚS MARÍA', 1, 1);
CALL insert_municipality('PABELLÓN DE ARTEAGA', 1, 1);
CALL insert_municipality('RINCÓN DE ROMOS', 1, 1);
CALL insert_municipality('SAN JOSÉ DE GRACIA', 1, 1);
CALL insert_municipality('TEPEZALÁ', 1, 1);
CALL insert_municipality('EL LLANO', 1, 1);
CALL insert_municipality('SAN FRANCISCO DE LOS ROMO', 1, 1);

CALL insert_state('BAJA CALIFORNIA', 1);
CALL insert_municipality('ENSENADA', 2, 1);
CALL insert_municipality('MEXICALI', 2, 1);
CALL insert_municipality('TECATE', 2, 1);
CALL insert_municipality('TIJUANA', 2, 1);
CALL insert_municipality('PLAYAS DE ROSARITO', 2, 1);

CALL insert_state('BAJA CALIFORNIA SUR', 1);
CALL insert_municipality('COMONDÚ', 3, 1);
CALL insert_municipality('MULEGÉ', 3, 1);
CALL insert_municipality('LA PAZ', 3, 1);
CALL insert_municipality('LOS CABOS', 3, 1);
CALL insert_municipality('LORETO', 3, 1);

CALL insert_state('CAMPECHE', 1);
CALL insert_municipality('CALKINÍ', 4, 1);
CALL insert_municipality('CAMPECHE', 4, 1);
CALL insert_municipality('CARMEN', 4, 1);
CALL insert_municipality('CHAMPOTÓN', 4, 1);
CALL insert_municipality('HECELCHAKÁN', 4, 1);
CALL insert_municipality('HOPELCHÉN', 4, 1);
CALL insert_municipality('PALIZADA', 4, 1);
CALL insert_municipality('TENABO', 4, 1);
CALL insert_municipality('ESCÁRCEGA', 4, 1);
CALL insert_municipality('CALAKMUL', 4, 1);
CALL insert_municipality('CANDELARIA', 4, 1);

CALL insert_state('CHIAPAS', 1);
CALL insert_municipality('ACACOYAGUA', 5, 1);
CALL insert_municipality('ACALA', 5, 1);
CALL insert_municipality('ACAPETAHUA', 5, 1);
CALL insert_municipality('ALTAMIRANO', 5, 1);
CALL insert_municipality('AMATÁN', 5, 1);
CALL insert_municipality('AMATENANGO DE LA FRONTERA', 5, 1);
CALL insert_municipality('AMATENANGO DEL VALLE', 5, 1);
CALL insert_municipality('ANGEL ALBINO CORZO', 5, 1);
CALL insert_municipality('ARRIAGA', 5, 1);
CALL insert_municipality('BEJUCAL DE OCAMPO', 5, 1);
CALL insert_municipality('BELLA VISTA', 5, 1);
CALL insert_municipality('BERRIOZÁBAL', 5, 1);
CALL insert_municipality('BOCHIL', 5, 1);
CALL insert_municipality('EL BOSQUE', 5, 1);
CALL insert_municipality('CACAHOATÁN', 5, 1);
CALL insert_municipality('CATAZAJÁ', 5, 1);
CALL insert_municipality('CINTALAPA', 5, 1);
CALL insert_municipality('COAPILLA', 5, 1);
CALL insert_municipality('COMITÁN DE DOMÍNGUEZ', 5, 1);
CALL insert_municipality('LA CONCORDIA', 5, 1);
CALL insert_municipality('COPAINALÁ', 5, 1);
CALL insert_municipality('CHALCHIHUITÁN', 5, 1);
CALL insert_municipality('CHAMULA', 5, 1);
CALL insert_municipality('CHANAL', 5, 1);
CALL insert_municipality('CHAPULTENANGO', 5, 1);
CALL insert_municipality('CHENALHÓ', 5, 1);
CALL insert_municipality('CHIAPA DE CORZO', 5, 1);
CALL insert_municipality('CHIAPILLA', 5, 1);
CALL insert_municipality('CHICOASÉN', 5, 1);
CALL insert_municipality('CHICOMUSELO', 5, 1);
CALL insert_municipality('CHILÓN', 5, 1);
CALL insert_municipality('ESCUINTLA', 5, 1);
CALL insert_municipality('FRANCISCO LEÓN', 5, 1);
CALL insert_municipality('FRONTERA COMALAPA', 5, 1);
CALL insert_municipality('FRONTERA HIDALGO', 5, 1);
CALL insert_municipality('LA GRANDEZA', 5, 1);
CALL insert_municipality('HUEHUETÁN', 5, 1);
CALL insert_municipality('HUIXTÁN', 5, 1);
CALL insert_municipality('HUITIUPÁN', 5, 1);
CALL insert_municipality('HUIXTLA', 5, 1);
CALL insert_municipality('LA INDEPENDENCIA', 5, 1);
CALL insert_municipality('IXHUATÁN', 5, 1);
CALL insert_municipality('IXTACOMITÁN', 5, 1);
CALL insert_municipality('IXTAPA', 5, 1);
CALL insert_municipality('IXTAPANGAJOYA', 5, 1);
CALL insert_municipality('JIQUIPILAS', 5, 1);
CALL insert_municipality('JITOTOL', 5, 1);
CALL insert_municipality('JUÁREZ', 5, 1);
CALL insert_municipality('LARRÁINZAR', 5, 1);
CALL insert_municipality('LA LIBERTAD', 5, 1);
CALL insert_municipality('MAPASTEPEC', 5, 1);
CALL insert_municipality('LAS MARGARITAS', 5, 1);
CALL insert_municipality('MAZAPA DE MADERO', 5, 1);
CALL insert_municipality('MAZATÁN', 5, 1);
CALL insert_municipality('METAPA', 5, 1);
CALL insert_municipality('MITONTIC', 5, 1);
CALL insert_municipality('MOTOZINTLA', 5, 1);
CALL insert_municipality('NICOLÁS RUÍZ', 5, 1);
CALL insert_municipality('OCOSINGO', 5, 1);
CALL insert_municipality('OCOTEPEC', 5, 1);
CALL insert_municipality('OCOZOCOAUTLA DE ESPINOSA', 5, 1);
CALL insert_municipality('OSTUACÁN', 5, 1);
CALL insert_municipality('OSUMACINTA', 5, 1);
CALL insert_municipality('OXCHUC', 5, 1);
CALL insert_municipality('PALENQUE', 5, 1);
CALL insert_municipality('PANTELHÓ', 5, 1);
CALL insert_municipality('PANTEPEC', 5, 1);
CALL insert_municipality('PICHUCALCO', 5, 1);
CALL insert_municipality('PIJIJIAPAN', 5, 1);
CALL insert_municipality('EL PORVENIR', 5, 1);
CALL insert_municipality('VILLA COMALTITLÁN', 5, 1);
CALL insert_municipality('PUEBLO NUEVO SOLISTAHUACÁN', 5, 1);
CALL insert_municipality('RAYÓN', 5, 1);
CALL insert_municipality('REFORMA', 5, 1);
CALL insert_municipality('LAS ROSAS', 5, 1);
CALL insert_municipality('SABANILLA', 5, 1);
CALL insert_municipality('SALTO DE AGUA', 5, 1);
CALL insert_municipality('SAN CRISTÓBAL DE LAS CASAS', 5, 1);
CALL insert_municipality('SAN FERNANDO', 5, 1);
CALL insert_municipality('SILTEPEC', 5, 1);
CALL insert_municipality('SIMOJOVEL', 5, 1);
CALL insert_municipality('SITALÁ', 5, 1);
CALL insert_municipality('SOCOLTENANGO', 5, 1);
CALL insert_municipality('SOLOSUCHIAPA', 5, 1);
CALL insert_municipality('SOYALÓ', 5, 1);
CALL insert_municipality('SUCHIAPA', 5, 1);
CALL insert_municipality('SUCHIATE', 5, 1);
CALL insert_municipality('SUNUAPA', 5, 1);
CALL insert_municipality('TAPACHULA', 5, 1);
CALL insert_municipality('TAPALAPA', 5, 1);
CALL insert_municipality('TAPILULA', 5, 1);
CALL insert_municipality('TECPATÁN', 5, 1);
CALL insert_municipality('TENEJAPA', 5, 1);
CALL insert_municipality('TEOPISCA', 5, 1);
CALL insert_municipality('TILA', 5, 1);
CALL insert_municipality('TONALÁ', 5, 1);
CALL insert_municipality('TOTOLAPA', 5, 1);
CALL insert_municipality('LA TRINITARIA', 5, 1);
CALL insert_municipality('TUMBALÁ', 5, 1);
CALL insert_municipality('TUXTLA GUTIÉRREZ', 5, 1);
CALL insert_municipality('TUXTLA CHICO', 5, 1);
CALL insert_municipality('TUZANTÁN', 5, 1);
CALL insert_municipality('TZIMOL', 5, 1);
CALL insert_municipality('UNIÓN JUÁREZ', 5, 1);
CALL insert_municipality('VENUSTIANO CARRANZA', 5, 1);
CALL insert_municipality('VILLA CORZO', 5, 1);
CALL insert_municipality('VILLAFLORES', 5, 1);
CALL insert_municipality('YAJALÓN', 5, 1);
CALL insert_municipality('SAN LUCAS', 5, 1);
CALL insert_municipality('ZINACANTÁN', 5, 1);
CALL insert_municipality('SAN JUAN CANCUC', 5, 1);
CALL insert_municipality('ALDAMA', 5, 1);
CALL insert_municipality('BENEMÉRITO DE LAS AMÉRICAS', 5, 1);
CALL insert_municipality('MARAVILLA TENEJAPA', 5, 1);
CALL insert_municipality('MARQUÉS DE COMILLAS', 5, 1);
CALL insert_municipality('MONTECRISTO DE GUERRERO', 5, 1);
CALL insert_municipality('SAN ANDRÉS DURAZNAL', 5, 1);
CALL insert_municipality('SANTIAGO EL PINAR', 5, 1);

CALL insert_state('CHIHUAHUA', 1);
CALL insert_municipality('AHUMADA', 6, 1);
CALL insert_municipality('ALDAMA', 6, 1);
CALL insert_municipality('ALLENDE', 6, 1);
CALL insert_municipality('AQUILES SERDÁN', 6, 1);
CALL insert_municipality('ASCENSIÓN', 6, 1);
CALL insert_municipality('BACHÍNIVA', 6, 1);
CALL insert_municipality('BALLEZA', 6, 1);
CALL insert_municipality('BATOPILAS', 6, 1);
CALL insert_municipality('BOCOYNA', 6, 1);
CALL insert_municipality('BUENAVENTURA', 6, 1);
CALL insert_municipality('CAMARGO', 6, 1);
CALL insert_municipality('CARICHÍ', 6, 1);
CALL insert_municipality('CASAS GRANDES', 6, 1);
CALL insert_municipality('CORONADO', 6, 1);
CALL insert_municipality('COYAME DEL SOTOL', 6, 1);
CALL insert_municipality('LA CRUZ', 6, 1);
CALL insert_municipality('CUAUHTÉMOC', 6, 1);
CALL insert_municipality('CUSIHUIRIACHI', 6, 1);
CALL insert_municipality('CHIHUAHUA', 6, 1);
CALL insert_municipality('CHÍNIPAS', 6, 1);
CALL insert_municipality('DELICIAS', 6, 1);
CALL insert_municipality('DR. BELISARIO DOMÍNGUEZ', 6, 1);
CALL insert_municipality('GALEANA', 6, 1);
CALL insert_municipality('SANTA ISABEL', 6, 1);
CALL insert_municipality('GÓMEZ FARÍAS', 6, 1);
CALL insert_municipality('GRAN MORELOS', 6, 1);
CALL insert_municipality('GUACHOCHI', 6, 1);
CALL insert_municipality('GUADALUPE', 6, 1);
CALL insert_municipality('GUADALUPE Y CALVO', 6, 1);
CALL insert_municipality('GUAZAPARES', 6, 1);
CALL insert_municipality('GUERRERO', 6, 1);
CALL insert_municipality('HIDALGO DEL PARRAL', 6, 1);
CALL insert_municipality('HUEJOTITÁN', 6, 1);
CALL insert_municipality('IGNACIO ZARAGOZA', 6, 1);
CALL insert_municipality('JANOS', 6, 1);
CALL insert_municipality('JIMÉNEZ', 6, 1);
CALL insert_municipality('JUÁREZ', 6, 1);
CALL insert_municipality('JULIMES', 6, 1);
CALL insert_municipality('LÓPEZ', 6, 1);
CALL insert_municipality('MADERA', 6, 1);
CALL insert_municipality('MAGUARICHI', 6, 1);
CALL insert_municipality('MANUEL BENAVIDES', 6, 1);
CALL insert_municipality('MATACHÍ', 6, 1);
CALL insert_municipality('MATAMOROS', 6, 1);
CALL insert_municipality('MEOQUI', 6, 1);
CALL insert_municipality('MORELOS', 6, 1);
CALL insert_municipality('MORIS', 6, 1);
CALL insert_municipality('NAMIQUIPA', 6, 1);
CALL insert_municipality('NONOAVA', 6, 1);
CALL insert_municipality('NUEVO CASAS GRANDES', 6, 1);
CALL insert_municipality('OCAMPO', 6, 1);
CALL insert_municipality('OJINAGA', 6, 1);
CALL insert_municipality('PRAXEDIS G. GUERRERO', 6, 1);
CALL insert_municipality('RIVA PALACIO', 6, 1);
CALL insert_municipality('ROSALES', 6, 1);
CALL insert_municipality('ROSARIO', 6, 1);
CALL insert_municipality('SAN FRANCISCO DE BORJA', 6, 1);
CALL insert_municipality('SAN FRANCISCO DE CONCHOS', 6, 1);
CALL insert_municipality('SAN FRANCISCO DEL ORO', 6, 1);
CALL insert_municipality('SANTA BÁRBARA', 6, 1);
CALL insert_municipality('SATEVÓ', 6, 1);
CALL insert_municipality('SAUCILLO', 6, 1);
CALL insert_municipality('TEMÓSACHIC', 6, 1);
CALL insert_municipality('EL TULE', 6, 1);
CALL insert_municipality('URIQUE', 6, 1);
CALL insert_municipality('URUACHI', 6, 1);
CALL insert_municipality('VALLE DE ZARAGOZA', 6, 1);

CALL insert_state('CIUDAD DE MÉXICO', 1);
CALL insert_municipality('AZCAPOTZALCO', 7, 1);
CALL insert_municipality('COYOACÁN', 7, 1);
CALL insert_municipality('CUAJIMALPA DE MORELOS', 7, 1);
CALL insert_municipality('GUSTAVO A. MADERO', 7, 1);
CALL insert_municipality('IZTACALCO', 7, 1);
CALL insert_municipality('IZTAPALAPA', 7, 1);
CALL insert_municipality('LA MAGDALENA CONTRERAS', 7, 1);
CALL insert_municipality('MILPA ALTA', 7, 1);
CALL insert_municipality('ÁLVARO OBREGÓN', 7, 1);
CALL insert_municipality('TLÁHUAC', 7, 1);
CALL insert_municipality('TLALPAN', 7, 1);
CALL insert_municipality('XOCHIMILCO', 7, 1);
CALL insert_municipality('BENITO JUÁREZ', 7, 1);
CALL insert_municipality('CUAUHTÉMOC', 7, 1);
CALL insert_municipality('MIGUEL HIDALGO', 7, 1);
CALL insert_municipality('VENUSTIANO CARRANZA', 7, 1);

CALL insert_state('COAHULIA', 1);
CALL insert_municipality('ABASOLO', 8, 1);
CALL insert_municipality('ACUÑA', 8, 1);
CALL insert_municipality('ALLENDE', 8, 1);
CALL insert_municipality('ARTEAGA', 8, 1);
CALL insert_municipality('CANDELA', 8, 1);
CALL insert_municipality('CASTAÑOS', 8, 1);
CALL insert_municipality('CUATRO CIÉNEGAS', 8, 1);
CALL insert_municipality('ESCOBEDO', 8, 1);
CALL insert_municipality('FRANCISCO I. MADERO', 8, 1);
CALL insert_municipality('FRONTERA', 8, 1);
CALL insert_municipality('GENERAL CEPEDA', 8, 1);
CALL insert_municipality('GUERRERO', 8, 1);
CALL insert_municipality('HIDALGO', 8, 1);
CALL insert_municipality('JIMÉNEZ', 8, 1);
CALL insert_municipality('JUÁREZ', 8, 1);
CALL insert_municipality('LAMADRID', 8, 1);
CALL insert_municipality('MATAMOROS', 8, 1);
CALL insert_municipality('MONCLOVA', 8, 1);
CALL insert_municipality('MORELOS', 8, 1);
CALL insert_municipality('MÚZQUIZ', 8, 1);
CALL insert_municipality('NADADORES', 8, 1);
CALL insert_municipality('NAVA', 8, 1);
CALL insert_municipality('OCAMPO', 8, 1);
CALL insert_municipality('PARRAS', 8, 1);
CALL insert_municipality('PIEDRAS NEGRAS', 8, 1);
CALL insert_municipality('PROGRESO', 8, 1);
CALL insert_municipality('RAMOS ARIZPE', 8, 1);
CALL insert_municipality('SABINAS', 8, 1);
CALL insert_municipality('SACRAMENTO', 8, 1);
CALL insert_municipality('SALTILLO', 8, 1);
CALL insert_municipality('SAN BUENAVENTURA', 8, 1);
CALL insert_municipality('SAN JUAN DE SABINAS', 8, 1);
CALL insert_municipality('SAN PEDRO', 8, 1);
CALL insert_municipality('SIERRA MOJADA', 8, 1);
CALL insert_municipality('TORREÓN', 8, 1);
CALL insert_municipality('VIESCA', 8, 1);
CALL insert_municipality('VILLA UNIÓN', 8, 1);
CALL insert_municipality('ZARAGOZA', 8, 1);

CALL insert_state('COLIMA', 1);
CALL insert_municipality('ARMERÍA', 9, 1);
CALL insert_municipality('COLIMA', 9, 1);
CALL insert_municipality('COMALA', 9, 1);
CALL insert_municipality('COQUIMATLÁN', 9, 1);
CALL insert_municipality('CUAUHTÉMOC', 9, 1);
CALL insert_municipality('IXTLAHUACÁN', 9, 1);
CALL insert_municipality('MANZANILLO', 9, 1);
CALL insert_municipality('MINATITLÁN', 9, 1);
CALL insert_municipality('TECOMÁN', 9, 1);
CALL insert_municipality('VILLA DE ÁLVAREZ', 9, 1);
CALL insert_municipality('DURANGO', 9, 1);
CALL insert_municipality('DURANGO', 9, 1);
CALL insert_municipality('CANATLÁN', 9, 1);
CALL insert_municipality('CANELAS', 9, 1);
CALL insert_municipality('CONETO DE COMONFORT', 9, 1);
CALL insert_municipality('CUENCAMÉ', 9, 1);
CALL insert_municipality('GENERAL SIMÓN BOLÍVAR', 9, 1);
CALL insert_municipality('GÓMEZ PALACIO', 9, 1);
CALL insert_municipality('GUADALUPE VICTORIA', 9, 1);
CALL insert_municipality('GUANACEVÍ', 9, 1);
CALL insert_municipality('HIDALGO', 9, 1);
CALL insert_municipality('INDÉ', 9, 1);
CALL insert_municipality('LERDO', 9, 1);
CALL insert_municipality('MAPIMÍ', 9, 1);
CALL insert_municipality('MEZQUITAL', 9, 1);
CALL insert_municipality('NAZAS', 9, 1);
CALL insert_municipality('NOMBRE DE DIOS', 9, 1);
CALL insert_municipality('OCAMPO', 9, 1);
CALL insert_municipality('EL ORO', 9, 1);
CALL insert_municipality('OTÁEZ', 9, 1);
CALL insert_municipality('PÁNUCO DE CORONADO', 9, 1);
CALL insert_municipality('PEÑÓN BLANCO', 9, 1);
CALL insert_municipality('POANAS', 9, 1);
CALL insert_municipality('PUEBLO NUEVO', 9, 1);
CALL insert_municipality('RODEO', 9, 1);
CALL insert_municipality('SAN BERNARDO', 9, 1);
CALL insert_municipality('SAN DIMAS', 9, 1);
CALL insert_municipality('SAN JUAN DE GUADALUPE', 9, 1);
CALL insert_municipality('SAN JUAN DEL RÍO', 9, 1);
CALL insert_municipality('SAN LUIS DEL CORDERO', 9, 1);
CALL insert_municipality('SAN PEDRO DEL GALLO', 9, 1);
CALL insert_municipality('SANTA CLARA', 9, 1);
CALL insert_municipality('SANTIAGO PAPASQUIARO', 9, 1);
CALL insert_municipality('SÚCHIL', 9, 1);
CALL insert_municipality('TAMAZULA', 9, 1);
CALL insert_municipality('TEPEHUANES', 9, 1);
CALL insert_municipality('TLAHUALILO', 9, 1);
CALL insert_municipality('TOPIA', 9, 1);
CALL insert_municipality('VICENTE GUERRERO', 9, 1);
CALL insert_municipality('NUEVO IDEAL', 9, 1);

CALL insert_state('GUANAJUATO', 1);
CALL insert_municipality('ABASOLO', 10, 1);
CALL insert_municipality('ACÁMBARO', 10, 1);
CALL insert_municipality('SAN MIGUEL DE ALLENDE', 10, 1);
CALL insert_municipality('APASEO EL ALTO', 10, 1);
CALL insert_municipality('APASEO EL GRANDE', 10, 1);
CALL insert_municipality('ATARJEA', 10, 1);
CALL insert_municipality('CELAYA', 10, 1);
CALL insert_municipality('MANUEL DOBLADO', 10, 1);
CALL insert_municipality('COMONFORT', 10, 1);
CALL insert_municipality('CORONEO', 10, 1);
CALL insert_municipality('CORTAZAR', 10, 1);
CALL insert_municipality('CUERÁMARO', 10, 1);
CALL insert_municipality('DOCTOR MORA', 10, 1);
CALL insert_municipality('DOLORES HIDALGO CUNA DE LA INDEPENDENCIA NACIONAL', 10, 1);
CALL insert_municipality('GUANAJUATO', 10, 1);
CALL insert_municipality('HUANÍMARO', 10, 1);
CALL insert_municipality('IRAPUATO', 10, 1);
CALL insert_municipality('JARAL DEL PROGRESO', 10, 1);
CALL insert_municipality('JERÉCUARO', 10, 1);
CALL insert_municipality('LEÓN', 10, 1);
CALL insert_municipality('MOROLEÓN', 10, 1);
CALL insert_municipality('OCAMPO', 10, 1);
CALL insert_municipality('PÉNJAMO', 10, 1);
CALL insert_municipality('PUEBLO NUEVO', 10, 1);
CALL insert_municipality('PURÍSIMA DEL RINCÓN', 10, 1);
CALL insert_municipality('ROMITA', 10, 1);
CALL insert_municipality('SALAMANCA', 10, 1);
CALL insert_municipality('SALVATIERRA', 10, 1);
CALL insert_municipality('SAN DIEGO DE LA UNIÓN', 10, 1);
CALL insert_municipality('SAN FELIPE', 10, 1);
CALL insert_municipality('SAN FRANCISCO DEL RINCÓN', 10, 1);
CALL insert_municipality('SAN JOSÉ ITURBIDE', 10, 1);
CALL insert_municipality('SAN LUIS DE LA PAZ', 10, 1);
CALL insert_municipality('SANTA CATARINA', 10, 1);
CALL insert_municipality('SANTA CRUZ DE JUVENTINO ROSAS', 10, 1);
CALL insert_municipality('SANTIAGO MARAVATÍO', 10, 1);
CALL insert_municipality('SILAO DE LA VICTORIA', 10, 1);
CALL insert_municipality('TARANDACUAO', 10, 1);
CALL insert_municipality('TARIMORO', 10, 1);
CALL insert_municipality('TIERRA BLANCA', 10, 1);
CALL insert_municipality('URIANGATO', 10, 1);
CALL insert_municipality('VALLE DE SANTIAGO', 10, 1);
CALL insert_municipality('VICTORIA', 10, 1);
CALL insert_municipality('VILLAGRÁN', 10, 1);
CALL insert_municipality('XICHÚ', 10, 1);
CALL insert_municipality('YURIRIA', 10, 1);

CALL insert_state('GUERRERO', 1);
CALL insert_municipality('ACAPULCO DE JUÁREZ', 11, 1);
CALL insert_municipality('AHUACUOTZINGO', 11, 1);
CALL insert_municipality('AJUCHITLÁN DEL PROGRESO', 11, 1);
CALL insert_municipality('ALCOZAUCA DE GUERRERO', 11, 1);
CALL insert_municipality('ALPOYECA', 11, 1);
CALL insert_municipality('APAXTLA', 11, 1);
CALL insert_municipality('ARCELIA', 11, 1);
CALL insert_municipality('ATENANGO DEL RÍO', 11, 1);
CALL insert_municipality('ATLAMAJALCINGO DEL MONTE', 11, 1);
CALL insert_municipality('ATLIXTAC', 11, 1);
CALL insert_municipality('ATOYAC DE ÁLVAREZ', 11, 1);
CALL insert_municipality('AYUTLA DE LOS LIBRES', 11, 1);
CALL insert_municipality('AZOYÚ', 11, 1);
CALL insert_municipality('BENITO JUÁREZ', 11, 1);
CALL insert_municipality('BUENAVISTA DE CUÉLLAR', 11, 1);
CALL insert_municipality('COAHUAYUTLA DE JOSÉ MARÍA IZAZAGA', 11, 1);
CALL insert_municipality('COCULA', 11, 1);
CALL insert_municipality('COPALA', 11, 1);
CALL insert_municipality('COPALILLO', 11, 1);
CALL insert_municipality('COPANATOYAC', 11, 1);
CALL insert_municipality('COYUCA DE BENÍTEZ', 11, 1);
CALL insert_municipality('COYUCA DE CATALÁN', 11, 1);
CALL insert_municipality('CUAJINICUILAPA', 11, 1);
CALL insert_municipality('CUALÁC', 11, 1);
CALL insert_municipality('CUAUTEPEC', 11, 1);
CALL insert_municipality('CUETZALA DEL PROGRESO', 11, 1);
CALL insert_municipality('CUTZAMALA DE PINZÓN', 11, 1);
CALL insert_municipality('CHILAPA DE ÁLVAREZ', 11, 1);
CALL insert_municipality('CHILPANCINGO DE LOS BRAVO', 11, 1);
CALL insert_municipality('FLORENCIO VILLARREAL', 11, 1);
CALL insert_municipality('GENERAL CANUTO A. NERI', 11, 1);
CALL insert_municipality('GENERAL HELIODORO CASTILLO', 11, 1);
CALL insert_municipality('HUAMUXTITLÁN', 11, 1);
CALL insert_municipality('HUITZUCO DE LOS FIGUEROA', 11, 1);
CALL insert_municipality('IGUALA DE LA INDEPENDENCIA', 11, 1);
CALL insert_municipality('IGUALAPA', 11, 1);
CALL insert_municipality('IXCATEOPAN DE CUAUHTÉMOC', 11, 1);
CALL insert_municipality('ZIHUATANEJO DE AZUETA', 11, 1);
CALL insert_municipality('JUAN R. ESCUDERO', 11, 1);
CALL insert_municipality('LEONARDO BRAVO', 11, 1);
CALL insert_municipality('MALINALTEPEC', 11, 1);
CALL insert_municipality('MÁRTIR DE CUILAPAN', 11, 1);
CALL insert_municipality('METLATÓNOC', 11, 1);
CALL insert_municipality('MOCHITLÁN', 11, 1);
CALL insert_municipality('OLINALÁ', 11, 1);
CALL insert_municipality('OMETEPEC', 11, 1);
CALL insert_municipality('PEDRO ASCENCIO ALQUISIRAS', 11, 1);
CALL insert_municipality('PETATLÁN', 11, 1);
CALL insert_municipality('PILCAYA', 11, 1);
CALL insert_municipality('PUNGARABATO', 11, 1);
CALL insert_municipality('QUECHULTENANGO', 11, 1);
CALL insert_municipality('SAN LUIS ACATLÁN', 11, 1);
CALL insert_municipality('SAN MARCOS', 11, 1);
CALL insert_municipality('SAN MIGUEL TOTOLAPAN', 11, 1);
CALL insert_municipality('TAXCO DE ALARCÓN', 11, 1);
CALL insert_municipality('TECOANAPA', 11, 1);
CALL insert_municipality('TÉCPAN DE GALEANA', 11, 1);
CALL insert_municipality('TELOLOAPAN', 11, 1);
CALL insert_municipality('TEPECOACUILCO DE TRUJANO', 11, 1);
CALL insert_municipality('TETIPAC', 11, 1);
CALL insert_municipality('TIXTLA DE GUERRERO', 11, 1);
CALL insert_municipality('TLACOACHISTLAHUACA', 11, 1);
CALL insert_municipality('TLACOAPA', 11, 1);
CALL insert_municipality('TLALCHAPA', 11, 1);
CALL insert_municipality('TLALIXTAQUILLA DE MALDONADO', 11, 1);
CALL insert_municipality('TLAPA DE COMONFORT', 11, 1);
CALL insert_municipality('TLAPEHUALA', 11, 1);
CALL insert_municipality('LA UNIÓN DE ISIDORO MONTES DE OCA', 11, 1);
CALL insert_municipality('XALPATLÁHUAC', 11, 1);
CALL insert_municipality('XOCHIHUEHUETLÁN', 11, 1);
CALL insert_municipality('XOCHISTLAHUACA', 11, 1);
CALL insert_municipality('ZAPOTITLÁN TABLAS', 11, 1);
CALL insert_municipality('ZIRÁNDARO', 11, 1);
CALL insert_municipality('ZITLALA', 11, 1);
CALL insert_municipality('EDUARDO NERI', 11, 1);
CALL insert_municipality('ACATEPEC', 11, 1);
CALL insert_municipality('MARQUELIA', 11, 1);
CALL insert_municipality('COCHOAPA EL GRANDE', 11, 1);
CALL insert_municipality('JOSÉ JOAQUÍN DE HERRERA', 11, 1);
CALL insert_municipality('JUCHITÁN', 11, 1);
CALL insert_municipality('ILIATENCO', 11, 1);

CALL insert_state('HIDALGO', 1);
CALL insert_municipality('ACATLÁN', 12, 1);
CALL insert_municipality('ACAXOCHITLÁN', 12, 1);
CALL insert_municipality('ACTOPAN', 12, 1);
CALL insert_municipality('AGUA BLANCA DE ITURBIDE', 12, 1);
CALL insert_municipality('AJACUBA', 12, 1);
CALL insert_municipality('ALFAJAYUCAN', 12, 1);
CALL insert_municipality('ALMOLOYA', 12, 1);
CALL insert_municipality('APAN', 12, 1);
CALL insert_municipality('EL ARENAL', 12, 1);
CALL insert_municipality('ATITALAQUIA', 12, 1);
CALL insert_municipality('ATLAPEXCO', 12, 1);
CALL insert_municipality('ATOTONILCO EL GRANDE', 12, 1);
CALL insert_municipality('ATOTONILCO DE TULA', 12, 1);
CALL insert_municipality('CALNALI', 12, 1);
CALL insert_municipality('CARDONAL', 12, 1);
CALL insert_municipality('CUAUTEPEC DE HINOJOSA', 12, 1);
CALL insert_municipality('CHAPANTONGO', 12, 1);
CALL insert_municipality('CHAPULHUACÁN', 12, 1);
CALL insert_municipality('CHILCUAUTLA', 12, 1);
CALL insert_municipality('ELOXOCHITLÁN', 12, 1);
CALL insert_municipality('EMILIANO ZAPATA', 12, 1);
CALL insert_municipality('EPAZOYUCAN', 12, 1);
CALL insert_municipality('FRANCISCO I. MADERO', 12, 1);
CALL insert_municipality('HUASCA DE OCAMPO', 12, 1);
CALL insert_municipality('HUAUTLA', 12, 1);
CALL insert_municipality('HUAZALINGO', 12, 1);
CALL insert_municipality('HUEHUETLA', 12, 1);
CALL insert_municipality('HUEJUTLA DE REYES', 12, 1);
CALL insert_municipality('HUICHAPAN', 12, 1);
CALL insert_municipality('IXMIQUILPAN', 12, 1);
CALL insert_municipality('JACALA DE LEDEZMA', 12, 1);
CALL insert_municipality('JALTOCÁN', 12, 1);
CALL insert_municipality('JUÁREZ HIDALGO', 12, 1);
CALL insert_municipality('LOLOTLA', 12, 1);
CALL insert_municipality('METEPEC', 12, 1);
CALL insert_municipality('SAN AGUSTÍN METZQUITITLÁN', 12, 1);
CALL insert_municipality('METZTITLÁN', 12, 1);
CALL insert_municipality('MINERAL DEL CHICO', 12, 1);
CALL insert_municipality('MINERAL DEL MONTE', 12, 1);
CALL insert_municipality('LA MISIÓN', 12, 1);
CALL insert_municipality('MIXQUIAHUALA DE JUÁREZ', 12, 1);
CALL insert_municipality('MOLANGO DE ESCAMILLA', 12, 1);
CALL insert_municipality('NICOLÁS FLORES', 12, 1);
CALL insert_municipality('NOPALA DE VILLAGRÁN', 12, 1);
CALL insert_municipality('OMITLÁN DE JUÁREZ', 12, 1);
CALL insert_municipality('SAN FELIPE ORIZATLÁN', 12, 1);
CALL insert_municipality('PACULA', 12, 1);
CALL insert_municipality('PACHUCA DE SOTO', 12, 1);
CALL insert_municipality('PISAFLORES', 12, 1);
CALL insert_municipality('PROGRESO DE OBREGÓN', 12, 1);
CALL insert_municipality('MINERAL DE LA REFORMA', 12, 1);
CALL insert_municipality('SAN AGUSTÍN TLAXIACA', 12, 1);
CALL insert_municipality('SAN BARTOLO TUTOTEPEC', 12, 1);
CALL insert_municipality('SAN SALVADOR', 12, 1);
CALL insert_municipality('SANTIAGO DE ANAYA', 12, 1);
CALL insert_municipality('SANTIAGO TULANTEPEC DE LUGO GUERRERO', 12, 1);
CALL insert_municipality('SINGUILUCAN', 12, 1);
CALL insert_municipality('TASQUILLO', 12, 1);
CALL insert_municipality('TECOZAUTLA', 12, 1);
CALL insert_municipality('TENANGO DE DORIA', 12, 1);
CALL insert_municipality('TEPEAPULCO', 12, 1);
CALL insert_municipality('TEPEHUACÁN DE GUERRERO', 12, 1);
CALL insert_municipality('TEPEJI DEL RÍO DE OCAMPO', 12, 1);
CALL insert_municipality('TEPETITLÁN', 12, 1);
CALL insert_municipality('TETEPANGO', 12, 1);
CALL insert_municipality('VILLA DE TEZONTEPEC', 12, 1);
CALL insert_municipality('TEZONTEPEC DE ALDAMA', 12, 1);
CALL insert_municipality('TIANGUISTENGO', 12, 1);
CALL insert_municipality('TIZAYUCA', 12, 1);
CALL insert_municipality('TLAHUELILPAN', 12, 1);
CALL insert_municipality('TLAHUILTEPA', 12, 1);
CALL insert_municipality('TLANALAPA', 12, 1);
CALL insert_municipality('TLANCHINOL', 12, 1);
CALL insert_municipality('TLAXCOAPAN', 12, 1);
CALL insert_municipality('TOLCAYUCA', 12, 1);
CALL insert_municipality('TULA DE ALLENDE', 12, 1);
CALL insert_municipality('TULANCINGO DE BRAVO', 12, 1);
CALL insert_municipality('XOCHIATIPAN', 12, 1);
CALL insert_municipality('XOCHICOATLÁN', 12, 1);
CALL insert_municipality('YAHUALICA', 12, 1);
CALL insert_municipality('ZACUALTIPÁN DE ÁNGELES', 12, 1);
CALL insert_municipality('ZAPOTLÁN DE JUÁREZ', 12, 1);
CALL insert_municipality('ZEMPOALA', 12, 1);
CALL insert_municipality('ZIMAPÁN', 12, 1);

CALL insert_state('JALISCO', 1);
CALL insert_municipality('ACATIC', 13, 1);
CALL insert_municipality('ACATLÁN DE JUÁREZ', 13, 1);
CALL insert_municipality('AHUALULCO DE MERCADO', 13, 1);
CALL insert_municipality('AMACUECA', 13, 1);
CALL insert_municipality('AMATITÁN', 13, 1);
CALL insert_municipality('AMECA', 13, 1);
CALL insert_municipality('SAN JUANITO DE ESCOBEDO', 13, 1);
CALL insert_municipality('ARANDAS', 13, 1);
CALL insert_municipality('EL ARENAL', 13, 1);
CALL insert_municipality('ATEMAJAC DE BRIZUELA', 13, 1);
CALL insert_municipality('ATENGO', 13, 1);
CALL insert_municipality('ATENGUILLO', 13, 1);
CALL insert_municipality('ATOTONILCO EL ALTO', 13, 1);
CALL insert_municipality('ATOYAC', 13, 1);
CALL insert_municipality('AUTLÁN DE NAVARRO', 13, 1);
CALL insert_municipality('AYOTLÁN', 13, 1);
CALL insert_municipality('AYUTLA', 13, 1);
CALL insert_municipality('LA BARCA', 13, 1);
CALL insert_municipality('BOLAÑOS', 13, 1);
CALL insert_municipality('CABO CORRIENTES', 13, 1);
CALL insert_municipality('CASIMIRO CASTILLO', 13, 1);
CALL insert_municipality('CIHUATLÁN', 13, 1);
CALL insert_municipality('ZAPOTLÁN EL GRANDE', 13, 1);
CALL insert_municipality('COCULA', 13, 1);
CALL insert_municipality('COLOTLÁN', 13, 1);
CALL insert_municipality('CONCEPCIÓN DE BUENOS AIRES', 13, 1);
CALL insert_municipality('CUAUTITLÁN DE GARCÍA BARRAGÁN', 13, 1);
CALL insert_municipality('CUAUTLA', 13, 1);
CALL insert_municipality('CUQUÍO', 13, 1);
CALL insert_municipality('CHAPALA', 13, 1);
CALL insert_municipality('CHIMALTITÁN', 13, 1);
CALL insert_municipality('CHIQUILISTLÁN', 13, 1);
CALL insert_municipality('DEGOLLADO', 13, 1);
CALL insert_municipality('EJUTLA', 13, 1);
CALL insert_municipality('ENCARNACIÓN DE DÍAZ', 13, 1);
CALL insert_municipality('ETZATLÁN', 13, 1);
CALL insert_municipality('EL GRULLO', 13, 1);
CALL insert_municipality('GUACHINANGO', 13, 1);
CALL insert_municipality('GUADALAJARA', 13, 1);
CALL insert_municipality('HOSTOTIPAQUILLO', 13, 1);
CALL insert_municipality('HUEJÚCAR', 13, 1);
CALL insert_municipality('HUEJUQUILLA EL ALTO', 13, 1);
CALL insert_municipality('LA HUERTA', 13, 1);
CALL insert_municipality('IXTLAHUACÁN DE LOS MEMBRILLOS', 13, 1);
CALL insert_municipality('IXTLAHUACÁN DEL RÍO', 13, 1);
CALL insert_municipality('JALOSTOTITLÁN', 13, 1);
CALL insert_municipality('JAMAY', 13, 1);
CALL insert_municipality('JESÚS MARÍA', 13, 1);
CALL insert_municipality('JILOTLÁN DE LOS DOLORES', 13, 1);
CALL insert_municipality('JOCOTEPEC', 13, 1);
CALL insert_municipality('JUANACATLÁN', 13, 1);
CALL insert_municipality('JUCHITLÁN', 13, 1);
CALL insert_municipality('LAGOS DE MORENO', 13, 1);
CALL insert_municipality('EL LIMÓN', 13, 1);
CALL insert_municipality('MAGDALENA', 13, 1);
CALL insert_municipality('SANTA MARÍA DEL ORO', 13, 1);
CALL insert_municipality('LA MANZANILLA DE LA PAZ', 13, 1);
CALL insert_municipality('MASCOTA', 13, 1);
CALL insert_municipality('MAZAMITLA', 13, 1);
CALL insert_municipality('MEXTICACÁN', 13, 1);
CALL insert_municipality('MEZQUITIC', 13, 1);
CALL insert_municipality('MIXTLÁN', 13, 1);
CALL insert_municipality('OCOTLÁN', 13, 1);
CALL insert_municipality('OJUELOS DE JALISCO', 13, 1);
CALL insert_municipality('PIHUAMO', 13, 1);
CALL insert_municipality('PONCITLÁN', 13, 1);
CALL insert_municipality('PUERTO VALLARTA', 13, 1);
CALL insert_municipality('VILLA PURIFICACIÓN', 13, 1);
CALL insert_municipality('QUITUPAN', 13, 1);
CALL insert_municipality('EL SALTO', 13, 1);
CALL insert_municipality('SAN CRISTÓBAL DE LA BARRANCA', 13, 1);
CALL insert_municipality('SAN DIEGO DE ALEJANDRÍA', 13, 1);
CALL insert_municipality('SAN JUAN DE LOS LAGOS', 13, 1);
CALL insert_municipality('SAN JULIÁN', 13, 1);
CALL insert_municipality('SAN MARCOS', 13, 1);
CALL insert_municipality('SAN MARTÍN DE BOLAÑOS', 13, 1);
CALL insert_municipality('SAN MARTÍN HIDALGO', 13, 1);
CALL insert_municipality('SAN MIGUEL EL ALTO', 13, 1);
CALL insert_municipality('GÓMEZ FARÍAS', 13, 1);
CALL insert_municipality('SAN SEBASTIÁN DEL OESTE', 13, 1);
CALL insert_municipality('SANTA MARÍA DE LOS ÁNGELES', 13, 1);
CALL insert_municipality('SAYULA', 13, 1);
CALL insert_municipality('TALA', 13, 1);
CALL insert_municipality('TALPA DE ALLENDE', 13, 1);
CALL insert_municipality('TAMAZULA DE GORDIANO', 13, 1);
CALL insert_municipality('TAPALPA', 13, 1);
CALL insert_municipality('TECALITLÁN', 13, 1);
CALL insert_municipality('TECOLOTLÁN', 13, 1);
CALL insert_municipality('TECHALUTA DE MONTENEGRO', 13, 1);
CALL insert_municipality('TENAMAXTLÁN', 13, 1);
CALL insert_municipality('TEOCALTICHE', 13, 1);
CALL insert_municipality('TEOCUITATLÁN DE CORONA', 13, 1);
CALL insert_municipality('TEPATITLÁN DE MORELOS', 13, 1);
CALL insert_municipality('TEQUILA', 13, 1);
CALL insert_municipality('TEUCHITLÁN', 13, 1);
CALL insert_municipality('TIZAPÁN EL ALTO', 13, 1);
CALL insert_municipality('TLAJOMULCO DE ZÚÑIGA', 13, 1);
CALL insert_municipality('SAN PEDRO TLAQUEPAQUE', 13, 1);
CALL insert_municipality('TOLIMÁN', 13, 1);
CALL insert_municipality('TOMATLÁN', 13, 1);
CALL insert_municipality('TONALÁ', 13, 1);
CALL insert_municipality('TONAYA', 13, 1);
CALL insert_municipality('TONILA', 13, 1);
CALL insert_municipality('TOTATICHE', 13, 1);
CALL insert_municipality('TOTOTLÁN', 13, 1);
CALL insert_municipality('TUXCACUESCO', 13, 1);
CALL insert_municipality('TUXCUECA', 13, 1);
CALL insert_municipality('TUXPAN', 13, 1);
CALL insert_municipality('UNIÓN DE SAN ANTONIO', 13, 1);
CALL insert_municipality('UNIÓN DE TULA', 13, 1);
CALL insert_municipality('VALLE DE GUADALUPE', 13, 1);
CALL insert_municipality('VALLE DE JUÁREZ', 13, 1);
CALL insert_municipality('SAN GABRIEL', 13, 1);
CALL insert_municipality('VILLA CORONA', 13, 1);
CALL insert_municipality('VILLA GUERRERO', 13, 1);
CALL insert_municipality('VILLA HIDALGO', 13, 1);
CALL insert_municipality('CAÑADAS DE OBREGÓN', 13, 1);
CALL insert_municipality('YAHUALICA DE GONZÁLEZ GALLO', 13, 1);
CALL insert_municipality('ZACOALCO DE TORRES', 13, 1);
CALL insert_municipality('ZAPOPAN', 13, 1);
CALL insert_municipality('ZAPOTILTIC', 13, 1);
CALL insert_municipality('ZAPOTITLÁN DE VADILLO', 13, 1);
CALL insert_municipality('ZAPOTLÁN DEL REY', 13, 1);
CALL insert_municipality('ZAPOTLANEJO', 13, 1);
CALL insert_municipality('SAN IGNACIO CERRO GORDO', 13, 1);

CALL insert_state('ESTADO DE MÉXICO', 1);
CALL insert_municipality('ACAMBAY DE RUÍZ CASTAÑEDA', 14, 1);
CALL insert_municipality('ACOLMAN', 14, 1);
CALL insert_municipality('ACULCO', 14, 1);
CALL insert_municipality('ALMOLOYA DE ALQUISIRAS', 14, 1);
CALL insert_municipality('ALMOLOYA DE JUÁREZ', 14, 1);
CALL insert_municipality('ALMOLOYA DEL RÍO', 14, 1);
CALL insert_municipality('AMANALCO', 14, 1);
CALL insert_municipality('AMATEPEC', 14, 1);
CALL insert_municipality('AMECAMECA', 14, 1);
CALL insert_municipality('APAXCO', 14, 1);
CALL insert_municipality('ATENCO', 14, 1);
CALL insert_municipality('ATIZAPÁN', 14, 1);
CALL insert_municipality('ATIZAPÁN DE ZARAGOZA', 14, 1);
CALL insert_municipality('ATLACOMULCO', 14, 1);
CALL insert_municipality('ATLAUTLA', 14, 1);
CALL insert_municipality('AXAPUSCO', 14, 1);
CALL insert_municipality('AYAPANGO', 14, 1);
CALL insert_municipality('CALIMAYA', 14, 1);
CALL insert_municipality('CAPULHUAC', 14, 1);
CALL insert_municipality('COACALCO DE BERRIOZÁBAL', 14, 1);
CALL insert_municipality('COATEPEC HARINAS', 14, 1);
CALL insert_municipality('COCOTITLÁN', 14, 1);
CALL insert_municipality('COYOTEPEC', 14, 1);
CALL insert_municipality('CUAUTITLÁN', 14, 1);
CALL insert_municipality('CHALCO', 14, 1);
CALL insert_municipality('CHAPA DE MOTA', 14, 1);
CALL insert_municipality('CHAPULTEPEC', 14, 1);
CALL insert_municipality('CHIAUTLA', 14, 1);
CALL insert_municipality('CHICOLOAPAN', 14, 1);
CALL insert_municipality('CHICONCUAC', 14, 1);
CALL insert_municipality('CHIMALHUACÁN', 14, 1);
CALL insert_municipality('DONATO GUERRA', 14, 1);
CALL insert_municipality('ECATEPEC DE MORELOS', 14, 1);
CALL insert_municipality('ECATZINGO', 14, 1);
CALL insert_municipality('HUEHUETOCA', 14, 1);
CALL insert_municipality('HUEYPOXTLA', 14, 1);
CALL insert_municipality('HUIXQUILUCAN', 14, 1);
CALL insert_municipality('ISIDRO FABELA', 14, 1);
CALL insert_municipality('IXTAPALUCA', 14, 1);
CALL insert_municipality('IXTAPAN DE LA SAL', 14, 1);
CALL insert_municipality('IXTAPAN DEL ORO', 14, 1);
CALL insert_municipality('IXTLAHUACA', 14, 1);
CALL insert_municipality('XALATLACO', 14, 1);
CALL insert_municipality('JALTENCO', 14, 1);
CALL insert_municipality('JILOTEPEC', 14, 1);
CALL insert_municipality('JILOTZINGO', 14, 1);
CALL insert_municipality('JIQUIPILCO', 14, 1);
CALL insert_municipality('JOCOTITLÁN', 14, 1);
CALL insert_municipality('JOQUICINGO', 14, 1);
CALL insert_municipality('JUCHITEPEC', 14, 1);
CALL insert_municipality('LERMA', 14, 1);
CALL insert_municipality('MALINALCO', 14, 1);
CALL insert_municipality('MELCHOR OCAMPO', 14, 1);
CALL insert_municipality('METEPEC', 14, 1);
CALL insert_municipality('MEXICALTZINGO', 14, 1);
CALL insert_municipality('MORELOS', 14, 1);
CALL insert_municipality('NAUCALPAN DE JUÁREZ', 14, 1);
CALL insert_municipality('NEZAHUALCÓYOTL', 14, 1);
CALL insert_municipality('NEXTLALPAN', 14, 1);
CALL insert_municipality('NICOLÁS ROMERO', 14, 1);
CALL insert_municipality('NOPALTEPEC', 14, 1);
CALL insert_municipality('OCOYOACAC', 14, 1);
CALL insert_municipality('OCUILAN', 14, 1);
CALL insert_municipality('EL ORO', 14, 1);
CALL insert_municipality('OTUMBA', 14, 1);
CALL insert_municipality('OTZOLOAPAN', 14, 1);
CALL insert_municipality('OTZOLOTEPEC', 14, 1);
CALL insert_municipality('OZUMBA', 14, 1);
CALL insert_municipality('PAPALOTLA', 14, 1);
CALL insert_municipality('LA PAZ', 14, 1);
CALL insert_municipality('POLOTITLÁN', 14, 1);
CALL insert_municipality('RAYÓN', 14, 1);
CALL insert_municipality('SAN ANTONIO LA ISLA', 14, 1);
CALL insert_municipality('SAN FELIPE DEL PROGRESO', 14, 1);
CALL insert_municipality('SAN MARTÍN DE LAS PIRÁMIDES', 14, 1);
CALL insert_municipality('SAN MATEO ATENCO', 14, 1);
CALL insert_municipality('SAN SIMÓN DE GUERRERO', 14, 1);
CALL insert_municipality('SANTO TOMÁS', 14, 1);
CALL insert_municipality('SOYANIQUILPAN DE JUÁREZ', 14, 1);
CALL insert_municipality('SULTEPEC', 14, 1);
CALL insert_municipality('TECÁMAC', 14, 1);
CALL insert_municipality('TEJUPILCO', 14, 1);
CALL insert_municipality('TEMAMATLA', 14, 1);
CALL insert_municipality('TEMASCALAPA', 14, 1);
CALL insert_municipality('TEMASCALCINGO', 14, 1);
CALL insert_municipality('TEMASCALTEPEC', 14, 1);
CALL insert_municipality('TEMOAYA', 14, 1);
CALL insert_municipality('TENANCINGO', 14, 1);
CALL insert_municipality('TENANGO DEL AIRE', 14, 1);
CALL insert_municipality('TENANGO DEL VALLE', 14, 1);
CALL insert_municipality('TEOLOYUCAN', 14, 1);
CALL insert_municipality('TEOTIHUACÁN', 14, 1);
CALL insert_municipality('TEPETLAOXTOC', 14, 1);
CALL insert_municipality('TEPETLIXPA', 14, 1);
CALL insert_municipality('TEPOTZOTLÁN', 14, 1);
CALL insert_municipality('TEQUIXQUIAC', 14, 1);
CALL insert_municipality('TEXCALTITLÁN', 14, 1);
CALL insert_municipality('TEXCALYACAC', 14, 1);
CALL insert_municipality('TEXCOCO', 14, 1);
CALL insert_municipality('TEZOYUCA', 14, 1);
CALL insert_municipality('TIANGUISTENCO', 14, 1);
CALL insert_municipality('TIMILPAN', 14, 1);
CALL insert_municipality('TLALMANALCO', 14, 1);
CALL insert_municipality('TLALNEPANTLA DE BAZ', 14, 1);
CALL insert_municipality('TLATLAYA', 14, 1);
CALL insert_municipality('TOLUCA', 14, 1);
CALL insert_municipality('TONATICO', 14, 1);
CALL insert_municipality('TULTEPEC', 14, 1);
CALL insert_municipality('TULTITLÁN', 14, 1);
CALL insert_municipality('VALLE DE BRAVO', 14, 1);
CALL insert_municipality('VILLA DE ALLENDE', 14, 1);
CALL insert_municipality('VILLA DEL CARBÓN', 14, 1);
CALL insert_municipality('VILLA GUERRERO', 14, 1);
CALL insert_municipality('VILLA VICTORIA', 14, 1);
CALL insert_municipality('XONACATLÁN', 14, 1);
CALL insert_municipality('ZACAZONAPAN', 14, 1);
CALL insert_municipality('ZACUALPAN', 14, 1);
CALL insert_municipality('ZINACANTEPEC', 14, 1);
CALL insert_municipality('ZUMPAHUACÁN', 14, 1);
CALL insert_municipality('ZUMPANGO', 14, 1);
CALL insert_municipality('CUAUTITLÁN IZCALLI', 14, 1);
CALL insert_municipality('VALLE DE CHALCO SOLIDARIDAD', 14, 1);
CALL insert_municipality('LUVIANOS', 14, 1);
CALL insert_municipality('SAN JOSÉ DEL RINCÓN', 14, 1);
CALL insert_municipality('TONANITLA', 14, 1);

CALL insert_state('MICHOACÁN', 1);
CALL insert_municipality('ACUITZIO', 15, 1);
CALL insert_municipality('AGUILILLA', 15, 1);
CALL insert_municipality('ÁLVARO OBREGÓN', 15, 1);
CALL insert_municipality('ANGAMACUTIRO', 15, 1);
CALL insert_municipality('ANGANGUEO', 15, 1);
CALL insert_municipality('APATZINGÁN', 15, 1);
CALL insert_municipality('APORO', 15, 1);
CALL insert_municipality('AQUILA', 15, 1);
CALL insert_municipality('ARIO', 15, 1);
CALL insert_municipality('ARTEAGA', 15, 1);
CALL insert_municipality('BRISEÑAS', 15, 1);
CALL insert_municipality('BUENAVISTA', 15, 1);
CALL insert_municipality('CARÁCUARO', 15, 1);
CALL insert_municipality('COAHUAYANA', 15, 1);
CALL insert_municipality('COALCOMÁN DE VÁZQUEZ PALLARES', 15, 1);
CALL insert_municipality('COENEO', 15, 1);
CALL insert_municipality('CONTEPEC', 15, 1);
CALL insert_municipality('COPÁNDARO', 15, 1);
CALL insert_municipality('COTIJA', 15, 1);
CALL insert_municipality('CUITZEO', 15, 1);
CALL insert_municipality('CHARAPAN', 15, 1);
CALL insert_municipality('CHARO', 15, 1);
CALL insert_municipality('CHAVINDA', 15, 1);
CALL insert_municipality('CHERÁN', 15, 1);
CALL insert_municipality('CHILCHOTA', 15, 1);
CALL insert_municipality('CHINICUILA', 15, 1);
CALL insert_municipality('CHUCÁNDIRO', 15, 1);
CALL insert_municipality('CHURINTZIO', 15, 1);
CALL insert_municipality('CHURUMUCO', 15, 1);
CALL insert_municipality('ECUANDUREO', 15, 1);
CALL insert_municipality('EPITACIO HUERTA', 15, 1);
CALL insert_municipality('ERONGARÍCUARO', 15, 1);
CALL insert_municipality('GABRIEL ZAMORA', 15, 1);
CALL insert_municipality('HIDALGO', 15, 1);
CALL insert_municipality('LA HUACANA', 15, 1);
CALL insert_municipality('HUANDACAREO', 15, 1);
CALL insert_municipality('HUANIQUEO', 15, 1);
CALL insert_municipality('HUETAMO', 15, 1);
CALL insert_municipality('HUIRAMBA', 15, 1);
CALL insert_municipality('INDAPARAPEO', 15, 1);
CALL insert_municipality('IRIMBO', 15, 1);
CALL insert_municipality('IXTLÁN', 15, 1);
CALL insert_municipality('JACONA', 15, 1);
CALL insert_municipality('JIMÉNEZ', 15, 1);
CALL insert_municipality('JIQUILPAN', 15, 1);
CALL insert_municipality('JUÁREZ', 15, 1);
CALL insert_municipality('JUNGAPEO', 15, 1);
CALL insert_municipality('LAGUNILLAS', 15, 1);
CALL insert_municipality('MADERO', 15, 1);
CALL insert_municipality('MARAVATÍO', 15, 1);
CALL insert_municipality('MARCOS CASTELLANOS', 15, 1);
CALL insert_municipality('LÁZARO CÁRDENAS', 15, 1);
CALL insert_municipality('MORELIA', 15, 1);
CALL insert_municipality('MORELOS', 15, 1);
CALL insert_municipality('MÚGICA', 15, 1);
CALL insert_municipality('NAHUATZEN', 15, 1);
CALL insert_municipality('NOCUPÉTARO', 15, 1);
CALL insert_municipality('NUEVO PARANGARICUTIRO', 15, 1);
CALL insert_municipality('NUEVO URECHO', 15, 1);
CALL insert_municipality('NUMARÁN', 15, 1);
CALL insert_municipality('OCAMPO', 15, 1);
CALL insert_municipality('PAJACUARÁN', 15, 1);
CALL insert_municipality('PANINDÍCUARO', 15, 1);
CALL insert_municipality('PARÁCUARO', 15, 1);
CALL insert_municipality('PARACHO', 15, 1);
CALL insert_municipality('PÁTZCUARO', 15, 1);
CALL insert_municipality('PENJAMILLO', 15, 1);
CALL insert_municipality('PERIBÁN', 15, 1);
CALL insert_municipality('LA PIEDAD', 15, 1);
CALL insert_municipality('PURÉPERO', 15, 1);
CALL insert_municipality('PURUÁNDIRO', 15, 1);
CALL insert_municipality('QUERÉNDARO', 15, 1);
CALL insert_municipality('QUIROGA', 15, 1);
CALL insert_municipality('COJUMATLÁN DE RÉGULES', 15, 1);
CALL insert_municipality('LOS REYES', 15, 1);
CALL insert_municipality('SAHUAYO', 15, 1);
CALL insert_municipality('SAN LUCAS', 15, 1);
CALL insert_municipality('SANTA ANA MAYA', 15, 1);
CALL insert_municipality('SALVADOR ESCALANTE', 15, 1);
CALL insert_municipality('SENGUIO', 15, 1);
CALL insert_municipality('SUSUPUATO', 15, 1);
CALL insert_municipality('TACÁMBARO', 15, 1);
CALL insert_municipality('TANCÍTARO', 15, 1);
CALL insert_municipality('TANGAMANDAPIO', 15, 1);
CALL insert_municipality('TANGANCÍCUARO', 15, 1);
CALL insert_municipality('TANHUATO', 15, 1);
CALL insert_municipality('TARETAN', 15, 1);
CALL insert_municipality('TARÍMBARO', 15, 1);
CALL insert_municipality('TEPALCATEPEC', 15, 1);
CALL insert_municipality('TINGAMBATO', 15, 1);
CALL insert_municipality('TINGÜINDÍN', 15, 1);
CALL insert_municipality('TIQUICHEO DE NICOLÁS ROMERO', 15, 1);
CALL insert_municipality('TLALPUJAHUA', 15, 1);
CALL insert_municipality('TLAZAZALCA', 15, 1);
CALL insert_municipality('TOCUMBO', 15, 1);
CALL insert_municipality('TUMBISCATÍO', 15, 1);
CALL insert_municipality('TURICATO', 15, 1);
CALL insert_municipality('TUXPAN', 15, 1);
CALL insert_municipality('TUZANTLA', 15, 1);
CALL insert_municipality('TZINTZUNTZAN', 15, 1);
CALL insert_municipality('TZITZIO', 15, 1);
CALL insert_municipality('URUAPAN', 15, 1);
CALL insert_municipality('VENUSTIANO CARRANZA', 15, 1);
CALL insert_municipality('VILLAMAR', 15, 1);
CALL insert_municipality('VISTA HERMOSA', 15, 1);
CALL insert_municipality('YURÉCUARO', 15, 1);
CALL insert_municipality('ZACAPU', 15, 1);
CALL insert_municipality('ZAMORA', 15, 1);
CALL insert_municipality('ZINÁPARO', 15, 1);
CALL insert_municipality('ZINAPÉCUARO', 15, 1);
CALL insert_municipality('ZIRACUARETIRO', 15, 1);
CALL insert_municipality('ZITÁCUARO', 15, 1);
CALL insert_municipality('JOSÉ SIXTO VERDUZCO', 15, 1);

CALL insert_state('MORELOS', 1);
CALL insert_municipality('AMACUZAC', 16, 1);
CALL insert_municipality('ATLATLAHUCAN', 16, 1);
CALL insert_municipality('AXOCHIAPAN', 16, 1);
CALL insert_municipality('AYALA', 16, 1);
CALL insert_municipality('COATLÁN DEL RÍO', 16, 1);
CALL insert_municipality('CUAUTLA', 16, 1);
CALL insert_municipality('CUERNAVACA', 16, 1);
CALL insert_municipality('EMILIANO ZAPATA', 16, 1);
CALL insert_municipality('HUITZILAC', 16, 1);
CALL insert_municipality('JANTETELCO', 16, 1);
CALL insert_municipality('JIUTEPEC', 16, 1);
CALL insert_municipality('JOJUTLA', 16, 1);
CALL insert_municipality('JONACATEPEC DE LEANDRO VALLE', 16, 1);
CALL insert_municipality('MAZATEPEC', 16, 1);
CALL insert_municipality('MIACATLÁN', 16, 1);
CALL insert_municipality('OCUITUCO', 16, 1);
CALL insert_municipality('PUENTE DE IXTLA', 16, 1);
CALL insert_municipality('TEMIXCO', 16, 1);
CALL insert_municipality('TEPALCINGO', 16, 1);
CALL insert_municipality('TEPOZTLÁN', 16, 1);
CALL insert_municipality('TETECALA', 16, 1);
CALL insert_municipality('TETELA DEL VOLCÁN', 16, 1);
CALL insert_municipality('TLALNEPANTLA', 16, 1);
CALL insert_municipality('TLALTIZAPÁN DE ZAPATA', 16, 1);
CALL insert_municipality('TLAQUILTENANGO', 16, 1);
CALL insert_municipality('TLAYACAPAN', 16, 1);
CALL insert_municipality('TOTOLAPAN', 16, 1);
CALL insert_municipality('XOCHITEPEC', 16, 1);
CALL insert_municipality('YAUTEPEC', 16, 1);
CALL insert_municipality('YECAPIXTLA', 16, 1);
CALL insert_municipality('ZACATEPEC', 16, 1);
CALL insert_municipality('ZACUALPAN DE AMILPAS', 16, 1);
CALL insert_municipality('TEMOAC', 16, 1);
CALL insert_municipality('NAYARIT', 16, 1);
CALL insert_municipality('ACAPONETA', 16, 1);
CALL insert_municipality('AHUACATLÁN', 16, 1);
CALL insert_municipality('AMATLÁN DE CAÑAS', 16, 1);
CALL insert_municipality('COMPOSTELA', 16, 1);
CALL insert_municipality('HUAJICORI', 16, 1);
CALL insert_municipality('IXTLÁN DEL RÍO', 16, 1);
CALL insert_municipality('JALA', 16, 1);
CALL insert_municipality('XALISCO', 16, 1);
CALL insert_municipality('DEL NAYAR', 16, 1);
CALL insert_municipality('ROSAMORADA', 16, 1);
CALL insert_municipality('RUÍZ', 16, 1);
CALL insert_municipality('SAN BLAS', 16, 1);
CALL insert_municipality('SAN PEDRO LAGUNILLAS', 16, 1);
CALL insert_municipality('SANTA MARÍA DEL ORO', 16, 1);
CALL insert_municipality('SANTIAGO IXCUINTLA', 16, 1);
CALL insert_municipality('TECUALA', 16, 1);
CALL insert_municipality('TEPIC', 16, 1);
CALL insert_municipality('TUXPAN', 16, 1);
CALL insert_municipality('LA YESCA', 16, 1);
CALL insert_municipality('BAHÍA DE BANDERAS', 16, 1);

CALL insert_state('NUEVO LEÓN', 1);
CALL insert_municipality('ABASOLO', 17, 1);
CALL insert_municipality('AGUALEGUAS', 17, 1);
CALL insert_municipality('LOS ALDAMAS', 17, 1);
CALL insert_municipality('ALLENDE', 17, 1);
CALL insert_municipality('ANÁHUAC', 17, 1);
CALL insert_municipality('APODACA', 17, 1);
CALL insert_municipality('ARAMBERRI', 17, 1);
CALL insert_municipality('BUSTAMANTE', 17, 1);
CALL insert_municipality('CADEREYTA JIMÉNEZ', 17, 1);
CALL insert_municipality('EL CARMEN', 17, 1);
CALL insert_municipality('CERRALVO', 17, 1);
CALL insert_municipality('CIÉNEGA DE FLORES', 17, 1);
CALL insert_municipality('CHINA', 17, 1);
CALL insert_municipality('DOCTOR ARROYO', 17, 1);
CALL insert_municipality('DOCTOR COSS', 17, 1);
CALL insert_municipality('DOCTOR GONZÁLEZ', 17, 1);
CALL insert_municipality('GALEANA', 17, 1);
CALL insert_municipality('GARCÍA', 17, 1);
CALL insert_municipality('SAN PEDRO GARZA GARCÍA', 17, 1);
CALL insert_municipality('GENERAL BRAVO', 17, 1);
CALL insert_municipality('GENERAL ESCOBEDO', 17, 1);
CALL insert_municipality('GENERAL TERÁN', 17, 1);
CALL insert_municipality('GENERAL TREVIÑO', 17, 1);
CALL insert_municipality('GENERAL ZARAGOZA', 17, 1);
CALL insert_municipality('GENERAL ZUAZUA', 17, 1);
CALL insert_municipality('GUADALUPE', 17, 1);
CALL insert_municipality('LOS HERRERAS', 17, 1);
CALL insert_municipality('HIGUERAS', 17, 1);
CALL insert_municipality('HUALAHUISES', 17, 1);
CALL insert_municipality('ITURBIDE', 17, 1);
CALL insert_municipality('JUÁREZ', 17, 1);
CALL insert_municipality('LAMPAZOS DE NARANJO', 17, 1);
CALL insert_municipality('LINARES', 17, 1);
CALL insert_municipality('MARÍN', 17, 1);
CALL insert_municipality('MELCHOR OCAMPO', 17, 1);
CALL insert_municipality('MIER Y NORIEGA', 17, 1);
CALL insert_municipality('MINA', 17, 1);
CALL insert_municipality('MONTEMORELOS', 17, 1);
CALL insert_municipality('MONTERREY', 17, 1);
CALL insert_municipality('PARÁS', 17, 1);
CALL insert_municipality('PESQUERÍA', 17, 1);
CALL insert_municipality('LOS RAMONES', 17, 1);
CALL insert_municipality('RAYONES', 17, 1);
CALL insert_municipality('SABINAS HIDALGO', 17, 1);
CALL insert_municipality('SALINAS VICTORIA', 17, 1);
CALL insert_municipality('SAN NICOLÁS DE LOS GARZA', 17, 1);
CALL insert_municipality('HIDALGO', 17, 1);
CALL insert_municipality('SANTA CATARINA', 17, 1);
CALL insert_municipality('SANTIAGO', 17, 1);
CALL insert_municipality('VALLECILLO', 17, 1);
CALL insert_municipality('VILLALDAMA', 17, 1);

CALL insert_state('OAXACA', 1);
CALL insert_municipality('ABEJONES', 18, 1);
CALL insert_municipality('ACATLÁN DE PÉREZ FIGUEROA', 18, 1);
CALL insert_municipality('ASUNCIÓN CACALOTEPEC', 18, 1);
CALL insert_municipality('ASUNCIÓN CUYOTEPEJI', 18, 1);
CALL insert_municipality('ASUNCIÓN IXTALTEPEC', 18, 1);
CALL insert_municipality('ASUNCIÓN NOCHIXTLÁN', 18, 1);
CALL insert_municipality('ASUNCIÓN OCOTLÁN', 18, 1);
CALL insert_municipality('ASUNCIÓN TLACOLULITA', 18, 1);
CALL insert_municipality('AYOTZINTEPEC', 18, 1);
CALL insert_municipality('EL BARRIO DE LA SOLEDAD', 18, 1);
CALL insert_municipality('CALIHUALÁ', 18, 1);
CALL insert_municipality('CANDELARIA LOXICHA', 18, 1);
CALL insert_municipality('CIÉNEGA DE ZIMATLÁN', 18, 1);
CALL insert_municipality('CIUDAD IXTEPEC', 18, 1);
CALL insert_municipality('COATECAS ALTAS', 18, 1);
CALL insert_municipality('COICOYÁN DE LAS FLORES', 18, 1);
CALL insert_municipality('LA COMPAÑÍA', 18, 1);
CALL insert_municipality('CONCEPCIÓN BUENAVISTA', 18, 1);
CALL insert_municipality('CONCEPCIÓN PÁPALO', 18, 1);
CALL insert_municipality('CONSTANCIA DEL ROSARIO', 18, 1);
CALL insert_municipality('COSOLAPA', 18, 1);
CALL insert_municipality('COSOLTEPEC', 18, 1);
CALL insert_municipality('CUILÁPAM DE GUERRERO', 18, 1);
CALL insert_municipality('CUYAMECALCO VILLA DE ZARAGOZA', 18, 1);
CALL insert_municipality('CHAHUITES', 18, 1);
CALL insert_municipality('CHALCATONGO DE HIDALGO', 18, 1);
CALL insert_municipality('CHIQUIHUITLÁN DE BENITO JUÁREZ', 18, 1);
CALL insert_municipality('HEROICA CIUDAD DE EJUTLA DE CRESPO', 18, 1);
CALL insert_municipality('ELOXOCHITLÁN DE FLORES MAGÓN', 18, 1);
CALL insert_municipality('EL ESPINAL', 18, 1);
CALL insert_municipality('TAMAZULÁPAM DEL ESPÍRITU SANTO', 18, 1);
CALL insert_municipality('FRESNILLO DE TRUJANO', 18, 1);
CALL insert_municipality('GUADALUPE ETLA', 18, 1);
CALL insert_municipality('GUADALUPE DE RAMÍREZ', 18, 1);
CALL insert_municipality('GUELATAO DE JUÁREZ', 18, 1);
CALL insert_municipality('GUEVEA DE HUMBOLDT', 18, 1);
CALL insert_municipality('MESONES HIDALGO', 18, 1);
CALL insert_municipality('VILLA HIDALGO', 18, 1);
CALL insert_municipality('HEROICA CIUDAD DE HUAJUAPAN DE LEÓN', 18, 1);
CALL insert_municipality('HUAUTEPEC', 18, 1);
CALL insert_municipality('HUAUTLA DE JIMÉNEZ', 18, 1);
CALL insert_municipality('IXTLÁN DE JUÁREZ', 18, 1);
CALL insert_municipality('HEROICA CIUDAD DE JUCHITÁN DE ZARAGOZA', 18, 1);
CALL insert_municipality('LOMA BONITA', 18, 1);
CALL insert_municipality('MAGDALENA APASCO', 18, 1);
CALL insert_municipality('MAGDALENA JALTEPEC', 18, 1);
CALL insert_municipality('SANTA MAGDALENA JICOTLÁN', 18, 1);
CALL insert_municipality('MAGDALENA MIXTEPEC', 18, 1);
CALL insert_municipality('MAGDALENA OCOTLÁN', 18, 1);
CALL insert_municipality('MAGDALENA PEÑASCO', 18, 1);
CALL insert_municipality('MAGDALENA TEITIPAC', 18, 1);
CALL insert_municipality('MAGDALENA TEQUISISTLÁN', 18, 1);
CALL insert_municipality('MAGDALENA TLACOTEPEC', 18, 1);
CALL insert_municipality('MAGDALENA ZAHUATLÁN', 18, 1);
CALL insert_municipality('MARISCALA DE JUÁREZ', 18, 1);
CALL insert_municipality('MÁRTIRES DE TACUBAYA', 18, 1);
CALL insert_municipality('MATÍAS ROMERO AVENDAÑO', 18, 1);
CALL insert_municipality('MAZATLÁN VILLA DE FLORES', 18, 1);
CALL insert_municipality('MIAHUATLÁN DE PORFIRIO DÍAZ', 18, 1);
CALL insert_municipality('MIXISTLÁN DE LA REFORMA', 18, 1);
CALL insert_municipality('MONJAS', 18, 1);
CALL insert_municipality('NATIVIDAD', 18, 1);
CALL insert_municipality('NAZARENO ETLA', 18, 1);
CALL insert_municipality('NEJAPA DE MADERO', 18, 1);
CALL insert_municipality('IXPANTEPEC NIEVES', 18, 1);
CALL insert_municipality('SANTIAGO NILTEPEC', 18, 1);
CALL insert_municipality('OAXACA DE JUÁREZ', 18, 1);
CALL insert_municipality('OCOTLÁN DE MORELOS', 18, 1);
CALL insert_municipality('LA PE', 18, 1);
CALL insert_municipality('PINOTEPA DE DON LUIS', 18, 1);
CALL insert_municipality('PLUMA HIDALGO', 18, 1);
CALL insert_municipality('SAN JOSÉ DEL PROGRESO', 18, 1);
CALL insert_municipality('PUTLA VILLA DE GUERRERO', 18, 1);
CALL insert_municipality('SANTA CATARINA QUIOQUITANI', 18, 1);
CALL insert_municipality('REFORMA DE PINEDA', 18, 1);
CALL insert_municipality('LA REFORMA', 18, 1);
CALL insert_municipality('REYES ETLA', 18, 1);
CALL insert_municipality('ROJAS DE CUAUHTÉMOC', 18, 1);
CALL insert_municipality('SALINA CRUZ', 18, 1);
CALL insert_municipality('SAN AGUSTÍN AMATENGO', 18, 1);
CALL insert_municipality('SAN AGUSTÍN ATENANGO', 18, 1);
CALL insert_municipality('SAN AGUSTÍN CHAYUCO', 18, 1);
CALL insert_municipality('SAN AGUSTÍN DE LAS JUNTAS', 18, 1);
CALL insert_municipality('SAN AGUSTÍN ETLA', 18, 1);
CALL insert_municipality('SAN AGUSTÍN LOXICHA', 18, 1);
CALL insert_municipality('SAN AGUSTÍN TLACOTEPEC', 18, 1);
CALL insert_municipality('SAN AGUSTÍN YATARENI', 18, 1);
CALL insert_municipality('SAN ANDRÉS CABECERA NUEVA', 18, 1);
CALL insert_municipality('SAN ANDRÉS DINICUITI', 18, 1);
CALL insert_municipality('SAN ANDRÉS HUAXPALTEPEC', 18, 1);
CALL insert_municipality('SAN ANDRÉS HUAYÁPAM', 18, 1);
CALL insert_municipality('SAN ANDRÉS IXTLAHUACA', 18, 1);
CALL insert_municipality('SAN ANDRÉS LAGUNAS', 18, 1);
CALL insert_municipality('SAN ANDRÉS NUXIÑO', 18, 1);
CALL insert_municipality('SAN ANDRÉS PAXTLÁN', 18, 1);
CALL insert_municipality('SAN ANDRÉS SINAXTLA', 18, 1);
CALL insert_municipality('SAN ANDRÉS SOLAGA', 18, 1);
CALL insert_municipality('SAN ANDRÉS TEOTILÁLPAM', 18, 1);
CALL insert_municipality('SAN ANDRÉS TEPETLAPA', 18, 1);
CALL insert_municipality('SAN ANDRÉS YAÁ', 18, 1);
CALL insert_municipality('SAN ANDRÉS ZABACHE', 18, 1);
CALL insert_municipality('SAN ANDRÉS ZAUTLA', 18, 1);
CALL insert_municipality('SAN ANTONINO CASTILLO VELASCO', 18, 1);
CALL insert_municipality('SAN ANTONINO EL ALTO', 18, 1);
CALL insert_municipality('SAN ANTONINO MONTE VERDE', 18, 1);
CALL insert_municipality('SAN ANTONIO ACUTLA', 18, 1);
CALL insert_municipality('SAN ANTONIO DE LA CAL', 18, 1);
CALL insert_municipality('SAN ANTONIO HUITEPEC', 18, 1);
CALL insert_municipality('SAN ANTONIO NANAHUATÍPAM', 18, 1);
CALL insert_municipality('SAN ANTONIO SINICAHUA', 18, 1);
CALL insert_municipality('SAN ANTONIO TEPETLAPA', 18, 1);
CALL insert_municipality('SAN BALTAZAR CHICHICÁPAM', 18, 1);
CALL insert_municipality('SAN BALTAZAR LOXICHA', 18, 1);
CALL insert_municipality('SAN BALTAZAR YATZACHI EL BAJO', 18, 1);
CALL insert_municipality('SAN BARTOLO COYOTEPEC', 18, 1);
CALL insert_municipality('SAN BARTOLOMÉ AYAUTLA', 18, 1);
CALL insert_municipality('SAN BARTOLOMÉ LOXICHA', 18, 1);
CALL insert_municipality('SAN BARTOLOMÉ QUIALANA', 18, 1);
CALL insert_municipality('SAN BARTOLOMÉ YUCUAÑE', 18, 1);
CALL insert_municipality('SAN BARTOLOMÉ ZOOGOCHO', 18, 1);
CALL insert_municipality('SAN BARTOLO SOYALTEPEC', 18, 1);
CALL insert_municipality('SAN BARTOLO YAUTEPEC', 18, 1);
CALL insert_municipality('SAN BERNARDO MIXTEPEC', 18, 1);
CALL insert_municipality('SAN BLAS ATEMPA', 18, 1);
CALL insert_municipality('SAN CARLOS YAUTEPEC', 18, 1);
CALL insert_municipality('SAN CRISTÓBAL AMATLÁN', 18, 1);
CALL insert_municipality('SAN CRISTÓBAL AMOLTEPEC', 18, 1);
CALL insert_municipality('SAN CRISTÓBAL LACHIRIOAG', 18, 1);
CALL insert_municipality('SAN CRISTÓBAL SUCHIXTLAHUACA', 18, 1);
CALL insert_municipality('SAN DIONISIO DEL MAR', 18, 1);
CALL insert_municipality('SAN DIONISIO OCOTEPEC', 18, 1);
CALL insert_municipality('SAN DIONISIO OCOTLÁN', 18, 1);
CALL insert_municipality('SAN ESTEBAN ATATLAHUCA', 18, 1);
CALL insert_municipality('SAN FELIPE JALAPA DE DÍAZ', 18, 1);
CALL insert_municipality('SAN FELIPE TEJALÁPAM', 18, 1);
CALL insert_municipality('SAN FELIPE USILA', 18, 1);
CALL insert_municipality('SAN FRANCISCO CAHUACUÁ', 18, 1);
CALL insert_municipality('SAN FRANCISCO CAJONOS', 18, 1);
CALL insert_municipality('SAN FRANCISCO CHAPULAPA', 18, 1);
CALL insert_municipality('SAN FRANCISCO CHINDÚA', 18, 1);
CALL insert_municipality('SAN FRANCISCO DEL MAR', 18, 1);
CALL insert_municipality('SAN FRANCISCO HUEHUETLÁN', 18, 1);
CALL insert_municipality('SAN FRANCISCO IXHUATÁN', 18, 1);
CALL insert_municipality('SAN FRANCISCO JALTEPETONGO', 18, 1);
CALL insert_municipality('SAN FRANCISCO LACHIGOLÓ', 18, 1);
CALL insert_municipality('SAN FRANCISCO LOGUECHE', 18, 1);
CALL insert_municipality('SAN FRANCISCO NUXAÑO', 18, 1);
CALL insert_municipality('SAN FRANCISCO OZOLOTEPEC', 18, 1);
CALL insert_municipality('SAN FRANCISCO SOLA', 18, 1);
CALL insert_municipality('SAN FRANCISCO TELIXTLAHUACA', 18, 1);
CALL insert_municipality('SAN FRANCISCO TEOPAN', 18, 1);
CALL insert_municipality('SAN FRANCISCO TLAPANCINGO', 18, 1);
CALL insert_municipality('SAN GABRIEL MIXTEPEC', 18, 1);
CALL insert_municipality('SAN ILDEFONSO AMATLÁN', 18, 1);
CALL insert_municipality('SAN ILDEFONSO SOLA', 18, 1);
CALL insert_municipality('SAN ILDEFONSO VILLA ALTA', 18, 1);
CALL insert_municipality('SAN JACINTO AMILPAS', 18, 1);
CALL insert_municipality('SAN JACINTO TLACOTEPEC', 18, 1);
CALL insert_municipality('SAN JERÓNIMO COATLÁN', 18, 1);
CALL insert_municipality('SAN JERÓNIMO SILACAYOAPILLA', 18, 1);
CALL insert_municipality('SAN JERÓNIMO SOSOLA', 18, 1);
CALL insert_municipality('SAN JERÓNIMO TAVICHE', 18, 1);
CALL insert_municipality('SAN JERÓNIMO TECÓATL', 18, 1);
CALL insert_municipality('SAN JORGE NUCHITA', 18, 1);
CALL insert_municipality('SAN JOSÉ AYUQUILA', 18, 1);
CALL insert_municipality('SAN JOSÉ CHILTEPEC', 18, 1);
CALL insert_municipality('SAN JOSÉ DEL PEÑASCO', 18, 1);
CALL insert_municipality('SAN JOSÉ ESTANCIA GRANDE', 18, 1);
CALL insert_municipality('SAN JOSÉ INDEPENDENCIA', 18, 1);
CALL insert_municipality('SAN JOSÉ LACHIGUIRI', 18, 1);
CALL insert_municipality('SAN JOSÉ TENANGO', 18, 1);
CALL insert_municipality('SAN JUAN ACHIUTLA', 18, 1);
CALL insert_municipality('SAN JUAN ATEPEC', 18, 1);
CALL insert_municipality('ÁNIMAS TRUJANO', 18, 1);
CALL insert_municipality('SAN JUAN BAUTISTA ATATLAHUCA', 18, 1);
CALL insert_municipality('SAN JUAN BAUTISTA COIXTLAHUACA', 18, 1);
CALL insert_municipality('SAN JUAN BAUTISTA CUICATLÁN', 18, 1);
CALL insert_municipality('SAN JUAN BAUTISTA GUELACHE', 18, 1);
CALL insert_municipality('SAN JUAN BAUTISTA JAYACATLÁN', 18, 1);
CALL insert_municipality('SAN JUAN BAUTISTA LO DE SOTO', 18, 1);
CALL insert_municipality('SAN JUAN BAUTISTA SUCHITEPEC', 18, 1);
CALL insert_municipality('SAN JUAN BAUTISTA TLACOATZINTEPEC', 18, 1);
CALL insert_municipality('SAN JUAN BAUTISTA TLACHICHILCO', 18, 1);
CALL insert_municipality('SAN JUAN BAUTISTA TUXTEPEC', 18, 1);
CALL insert_municipality('SAN JUAN CACAHUATEPEC', 18, 1);
CALL insert_municipality('SAN JUAN CIENEGUILLA', 18, 1);
CALL insert_municipality('SAN JUAN COATZÓSPAM', 18, 1);
CALL insert_municipality('SAN JUAN COLORADO', 18, 1);
CALL insert_municipality('SAN JUAN COMALTEPEC', 18, 1);
CALL insert_municipality('SAN JUAN COTZOCÓN', 18, 1);
CALL insert_municipality('SAN JUAN CHICOMEZÚCHIL', 18, 1);
CALL insert_municipality('SAN JUAN CHILATECA', 18, 1);
CALL insert_municipality('SAN JUAN DEL ESTADO', 18, 1);
CALL insert_municipality('SAN JUAN DEL RÍO', 18, 1);
CALL insert_municipality('SAN JUAN DIUXI', 18, 1);
CALL insert_municipality('SAN JUAN EVANGELISTA ANALCO', 18, 1);
CALL insert_municipality('SAN JUAN GUELAVÍA', 18, 1);
CALL insert_municipality('SAN JUAN GUICHICOVI', 18, 1);
CALL insert_municipality('SAN JUAN IHUALTEPEC', 18, 1);
CALL insert_municipality('SAN JUAN JUQUILA MIXES', 18, 1);
CALL insert_municipality('SAN JUAN JUQUILA VIJANOS', 18, 1);
CALL insert_municipality('SAN JUAN LACHAO', 18, 1);
CALL insert_municipality('SAN JUAN LACHIGALLA', 18, 1);
CALL insert_municipality('SAN JUAN LAJARCIA', 18, 1);
CALL insert_municipality('SAN JUAN LALANA', 18, 1);
CALL insert_municipality('SAN JUAN DE LOS CUÉS', 18, 1);
CALL insert_municipality('SAN JUAN MAZATLÁN', 18, 1);
CALL insert_municipality('SAN JUAN MIXTEPEC', 18, 1);
CALL insert_municipality('SAN JUAN MIXTEPEC', 18, 1);
CALL insert_municipality('SAN JUAN ÑUMÍ', 18, 1);
CALL insert_municipality('SAN JUAN OZOLOTEPEC', 18, 1);
CALL insert_municipality('SAN JUAN PETLAPA', 18, 1);
CALL insert_municipality('SAN JUAN QUIAHIJE', 18, 1);
CALL insert_municipality('SAN JUAN QUIOTEPEC', 18, 1);
CALL insert_municipality('SAN JUAN SAYULTEPEC', 18, 1);
CALL insert_municipality('SAN JUAN TABAÁ', 18, 1);
CALL insert_municipality('SAN JUAN TAMAZOLA', 18, 1);
CALL insert_municipality('SAN JUAN TEITA', 18, 1);
CALL insert_municipality('SAN JUAN TEITIPAC', 18, 1);
CALL insert_municipality('SAN JUAN TEPEUXILA', 18, 1);
CALL insert_municipality('SAN JUAN TEPOSCOLULA', 18, 1);
CALL insert_municipality('SAN JUAN YAEÉ', 18, 1);
CALL insert_municipality('SAN JUAN YATZONA', 18, 1);
CALL insert_municipality('SAN JUAN YUCUITA', 18, 1);
CALL insert_municipality('SAN LORENZO', 18, 1);
CALL insert_municipality('SAN LORENZO ALBARRADAS', 18, 1);
CALL insert_municipality('SAN LORENZO CACAOTEPEC', 18, 1);
CALL insert_municipality('SAN LORENZO CUAUNECUILTITLA', 18, 1);
CALL insert_municipality('SAN LORENZO TEXMELÚCAN', 18, 1);
CALL insert_municipality('SAN LORENZO VICTORIA', 18, 1);
CALL insert_municipality('SAN LUCAS CAMOTLÁN', 18, 1);
CALL insert_municipality('SAN LUCAS OJITLÁN', 18, 1);
CALL insert_municipality('SAN LUCAS QUIAVINÍ', 18, 1);
CALL insert_municipality('SAN LUCAS ZOQUIÁPAM', 18, 1);
CALL insert_municipality('SAN LUIS AMATLÁN', 18, 1);
CALL insert_municipality('SAN MARCIAL OZOLOTEPEC', 18, 1);
CALL insert_municipality('SAN MARCOS ARTEAGA', 18, 1);
CALL insert_municipality('SAN MARTÍN DE LOS CANSECOS', 18, 1);
CALL insert_municipality('SAN MARTÍN HUAMELÚLPAM', 18, 1);
CALL insert_municipality('SAN MARTÍN ITUNYOSO', 18, 1);
CALL insert_municipality('SAN MARTÍN LACHILÁ', 18, 1);
CALL insert_municipality('SAN MARTÍN PERAS', 18, 1);
CALL insert_municipality('SAN MARTÍN TILCAJETE', 18, 1);
CALL insert_municipality('SAN MARTÍN TOXPALAN', 18, 1);
CALL insert_municipality('SAN MARTÍN ZACATEPEC', 18, 1);
CALL insert_municipality('SAN MATEO CAJONOS', 18, 1);
CALL insert_municipality('CAPULÁLPAM DE MÉNDEZ', 18, 1);
CALL insert_municipality('SAN MATEO DEL MAR', 18, 1);
CALL insert_municipality('SAN MATEO YOLOXOCHITLÁN', 18, 1);
CALL insert_municipality('SAN MATEO ETLATONGO', 18, 1);
CALL insert_municipality('SAN MATEO NEJÁPAM', 18, 1);
CALL insert_municipality('SAN MATEO PEÑASCO', 18, 1);
CALL insert_municipality('SAN MATEO PIÑAS', 18, 1);
CALL insert_municipality('SAN MATEO RÍO HONDO', 18, 1);
CALL insert_municipality('SAN MATEO SINDIHUI', 18, 1);
CALL insert_municipality('SAN MATEO TLAPILTEPEC', 18, 1);
CALL insert_municipality('SAN MELCHOR BETAZA', 18, 1);
CALL insert_municipality('SAN MIGUEL ACHIUTLA', 18, 1);
CALL insert_municipality('SAN MIGUEL AHUEHUETITLÁN', 18, 1);
CALL insert_municipality('SAN MIGUEL ALOÁPAM', 18, 1);
CALL insert_municipality('SAN MIGUEL AMATITLÁN', 18, 1);
CALL insert_municipality('SAN MIGUEL AMATLÁN', 18, 1);
CALL insert_municipality('SAN MIGUEL COATLÁN', 18, 1);
CALL insert_municipality('SAN MIGUEL CHICAHUA', 18, 1);
CALL insert_municipality('SAN MIGUEL CHIMALAPA', 18, 1);
CALL insert_municipality('SAN MIGUEL DEL PUERTO', 18, 1);
CALL insert_municipality('SAN MIGUEL DEL RÍO', 18, 1);
CALL insert_municipality('SAN MIGUEL EJUTLA', 18, 1);
CALL insert_municipality('SAN MIGUEL EL GRANDE', 18, 1);
CALL insert_municipality('SAN MIGUEL HUAUTLA', 18, 1);
CALL insert_municipality('SAN MIGUEL MIXTEPEC', 18, 1);
CALL insert_municipality('SAN MIGUEL PANIXTLAHUACA', 18, 1);
CALL insert_municipality('SAN MIGUEL PERAS', 18, 1);
CALL insert_municipality('SAN MIGUEL PIEDRAS', 18, 1);
CALL insert_municipality('SAN MIGUEL QUETZALTEPEC', 18, 1);
CALL insert_municipality('SAN MIGUEL SANTA FLOR', 18, 1);
CALL insert_municipality('VILLA SOLA DE VEGA', 18, 1);
CALL insert_municipality('SAN MIGUEL SOYALTEPEC', 18, 1);
CALL insert_municipality('SAN MIGUEL SUCHIXTEPEC', 18, 1);
CALL insert_municipality('VILLA TALEA DE CASTRO', 18, 1);
CALL insert_municipality('SAN MIGUEL TECOMATLÁN', 18, 1);
CALL insert_municipality('SAN MIGUEL TENANGO', 18, 1);
CALL insert_municipality('SAN MIGUEL TEQUIXTEPEC', 18, 1);
CALL insert_municipality('SAN MIGUEL TILQUIÁPAM', 18, 1);
CALL insert_municipality('SAN MIGUEL TLACAMAMA', 18, 1);
CALL insert_municipality('SAN MIGUEL TLACOTEPEC', 18, 1);
CALL insert_municipality('SAN MIGUEL TULANCINGO', 18, 1);
CALL insert_municipality('SAN MIGUEL YOTAO', 18, 1);
CALL insert_municipality('SAN NICOLÁS', 18, 1);
CALL insert_municipality('SAN NICOLÁS HIDALGO', 18, 1);
CALL insert_municipality('SAN PABLO COATLÁN', 18, 1);
CALL insert_municipality('SAN PABLO CUATRO VENADOS', 18, 1);
CALL insert_municipality('SAN PABLO ETLA', 18, 1);
CALL insert_municipality('SAN PABLO HUITZO', 18, 1);
CALL insert_municipality('SAN PABLO HUIXTEPEC', 18, 1);
CALL insert_municipality('SAN PABLO MACUILTIANGUIS', 18, 1);
CALL insert_municipality('SAN PABLO TIJALTEPEC', 18, 1);
CALL insert_municipality('SAN PABLO VILLA DE MITLA', 18, 1);
CALL insert_municipality('SAN PABLO YAGANIZA', 18, 1);
CALL insert_municipality('SAN PEDRO AMUZGOS', 18, 1);
CALL insert_municipality('SAN PEDRO APÓSTOL', 18, 1);
CALL insert_municipality('SAN PEDRO ATOYAC', 18, 1);
CALL insert_municipality('SAN PEDRO CAJONOS', 18, 1);
CALL insert_municipality('SAN PEDRO COXCALTEPEC CÁNTAROS', 18, 1);
CALL insert_municipality('SAN PEDRO COMITANCILLO', 18, 1);
CALL insert_municipality('SAN PEDRO EL ALTO', 18, 1);
CALL insert_municipality('SAN PEDRO HUAMELULA', 18, 1);
CALL insert_municipality('SAN PEDRO HUILOTEPEC', 18, 1);
CALL insert_municipality('SAN PEDRO IXCATLÁN', 18, 1);
CALL insert_municipality('SAN PEDRO IXTLAHUACA', 18, 1);
CALL insert_municipality('SAN PEDRO JALTEPETONGO', 18, 1);
CALL insert_municipality('SAN PEDRO JICAYÁN', 18, 1);
CALL insert_municipality('SAN PEDRO JOCOTIPAC', 18, 1);
CALL insert_municipality('SAN PEDRO JUCHATENGO', 18, 1);
CALL insert_municipality('SAN PEDRO MÁRTIR', 18, 1);
CALL insert_municipality('SAN PEDRO MÁRTIR QUIECHAPA', 18, 1);
CALL insert_municipality('SAN PEDRO MÁRTIR YUCUXACO', 18, 1);
CALL insert_municipality('SAN PEDRO MIXTEPEC', 18, 1);
CALL insert_municipality('SAN PEDRO MIXTEPEC', 18, 1);
CALL insert_municipality('SAN PEDRO MOLINOS', 18, 1);
CALL insert_municipality('SAN PEDRO NOPALA', 18, 1);
CALL insert_municipality('SAN PEDRO OCOPETATILLO', 18, 1);
CALL insert_municipality('SAN PEDRO OCOTEPEC', 18, 1);
CALL insert_municipality('SAN PEDRO POCHUTLA', 18, 1);
CALL insert_municipality('SAN PEDRO QUIATONI', 18, 1);
CALL insert_municipality('SAN PEDRO SOCHIÁPAM', 18, 1);
CALL insert_municipality('SAN PEDRO TAPANATEPEC', 18, 1);
CALL insert_municipality('SAN PEDRO TAVICHE', 18, 1);
CALL insert_municipality('SAN PEDRO TEOZACOALCO', 18, 1);
CALL insert_municipality('SAN PEDRO TEUTILA', 18, 1);
CALL insert_municipality('SAN PEDRO TIDAÁ', 18, 1);
CALL insert_municipality('SAN PEDRO TOPILTEPEC', 18, 1);
CALL insert_municipality('SAN PEDRO TOTOLÁPAM', 18, 1);
CALL insert_municipality('VILLA DE TUTUTEPEC', 18, 1);
CALL insert_municipality('SAN PEDRO YANERI', 18, 1);
CALL insert_municipality('SAN PEDRO YÓLOX', 18, 1);
CALL insert_municipality('SAN PEDRO Y SAN PABLO AYUTLA', 18, 1);
CALL insert_municipality('VILLA DE ETLA', 18, 1);
CALL insert_municipality('SAN PEDRO Y SAN PABLO TEPOSCOLULA', 18, 1);
CALL insert_municipality('SAN PEDRO Y SAN PABLO TEQUIXTEPEC', 18, 1);
CALL insert_municipality('SAN PEDRO YUCUNAMA', 18, 1);
CALL insert_municipality('SAN RAYMUNDO JALPAN', 18, 1);
CALL insert_municipality('SAN SEBASTIÁN ABASOLO', 18, 1);
CALL insert_municipality('SAN SEBASTIÁN COATLÁN', 18, 1);
CALL insert_municipality('SAN SEBASTIÁN IXCAPA', 18, 1);
CALL insert_municipality('SAN SEBASTIÁN NICANANDUTA', 18, 1);
CALL insert_municipality('SAN SEBASTIÁN RÍO HONDO', 18, 1);
CALL insert_municipality('SAN SEBASTIÁN TECOMAXTLAHUACA', 18, 1);
CALL insert_municipality('SAN SEBASTIÁN TEITIPAC', 18, 1);
CALL insert_municipality('SAN SEBASTIÁN TUTLA', 18, 1);
CALL insert_municipality('SAN SIMÓN ALMOLONGAS', 18, 1);
CALL insert_municipality('SAN SIMÓN ZAHUATLÁN', 18, 1);
CALL insert_municipality('SANTA ANA', 18, 1);
CALL insert_municipality('SANTA ANA ATEIXTLAHUACA', 18, 1);
CALL insert_municipality('SANTA ANA CUAUHTÉMOC', 18, 1);
CALL insert_municipality('SANTA ANA DEL VALLE', 18, 1);
CALL insert_municipality('SANTA ANA TAVELA', 18, 1);
CALL insert_municipality('SANTA ANA TLAPACOYAN', 18, 1);
CALL insert_municipality('SANTA ANA YARENI', 18, 1);
CALL insert_municipality('SANTA ANA ZEGACHE', 18, 1);
CALL insert_municipality('SANTA CATALINA QUIERÍ', 18, 1);
CALL insert_municipality('SANTA CATARINA CUIXTLA', 18, 1);
CALL insert_municipality('SANTA CATARINA IXTEPEJI', 18, 1);
CALL insert_municipality('SANTA CATARINA JUQUILA', 18, 1);
CALL insert_municipality('SANTA CATARINA LACHATAO', 18, 1);
CALL insert_municipality('SANTA CATARINA LOXICHA', 18, 1);
CALL insert_municipality('SANTA CATARINA MECHOACÁN', 18, 1);
CALL insert_municipality('SANTA CATARINA MINAS', 18, 1);
CALL insert_municipality('SANTA CATARINA QUIANÉ', 18, 1);
CALL insert_municipality('SANTA CATARINA TAYATA', 18, 1);
CALL insert_municipality('SANTA CATARINA TICUÁ', 18, 1);
CALL insert_municipality('SANTA CATARINA YOSONOTÚ', 18, 1);
CALL insert_municipality('SANTA CATARINA ZAPOQUILA', 18, 1);
CALL insert_municipality('SANTA CRUZ ACATEPEC', 18, 1);
CALL insert_municipality('SANTA CRUZ AMILPAS', 18, 1);
CALL insert_municipality('SANTA CRUZ DE BRAVO', 18, 1);
CALL insert_municipality('SANTA CRUZ ITUNDUJIA', 18, 1);
CALL insert_municipality('SANTA CRUZ MIXTEPEC', 18, 1);
CALL insert_municipality('SANTA CRUZ NUNDACO', 18, 1);
CALL insert_municipality('SANTA CRUZ PAPALUTLA', 18, 1);
CALL insert_municipality('SANTA CRUZ TACACHE DE MINA', 18, 1);
CALL insert_municipality('SANTA CRUZ TACAHUA', 18, 1);
CALL insert_municipality('SANTA CRUZ TAYATA', 18, 1);
CALL insert_municipality('SANTA CRUZ XITLA', 18, 1);
CALL insert_municipality('SANTA CRUZ XOXOCOTLÁN', 18, 1);
CALL insert_municipality('SANTA CRUZ ZENZONTEPEC', 18, 1);
CALL insert_municipality('SANTA GERTRUDIS', 18, 1);
CALL insert_municipality('SANTA INÉS DEL MONTE', 18, 1);
CALL insert_municipality('SANTA INÉS YATZECHE', 18, 1);
CALL insert_municipality('SANTA LUCÍA DEL CAMINO', 18, 1);
CALL insert_municipality('SANTA LUCÍA MIAHUATLÁN', 18, 1);
CALL insert_municipality('SANTA LUCÍA MONTEVERDE', 18, 1);
CALL insert_municipality('SANTA LUCÍA OCOTLÁN', 18, 1);
CALL insert_municipality('SANTA MARÍA ALOTEPEC', 18, 1);
CALL insert_municipality('SANTA MARÍA APAZCO', 18, 1);
CALL insert_municipality('SANTA MARÍA LA ASUNCIÓN', 18, 1);
CALL insert_municipality('HEROICA CIUDAD DE TLAXIACO', 18, 1);
CALL insert_municipality('AYOQUEZCO DE ALDAMA', 18, 1);
CALL insert_municipality('SANTA MARÍA ATZOMPA', 18, 1);
CALL insert_municipality('SANTA MARÍA CAMOTLÁN', 18, 1);
CALL insert_municipality('SANTA MARÍA COLOTEPEC', 18, 1);
CALL insert_municipality('SANTA MARÍA CORTIJO', 18, 1);
CALL insert_municipality('SANTA MARÍA COYOTEPEC', 18, 1);
CALL insert_municipality('SANTA MARÍA CHACHOÁPAM', 18, 1);
CALL insert_municipality('VILLA DE CHILAPA DE DÍAZ', 18, 1);
CALL insert_municipality('SANTA MARÍA CHILCHOTLA', 18, 1);
CALL insert_municipality('SANTA MARÍA CHIMALAPA', 18, 1);
CALL insert_municipality('SANTA MARÍA DEL ROSARIO', 18, 1);
CALL insert_municipality('SANTA MARÍA DEL TULE', 18, 1);
CALL insert_municipality('SANTA MARÍA ECATEPEC', 18, 1);
CALL insert_municipality('SANTA MARÍA GUELACÉ', 18, 1);
CALL insert_municipality('SANTA MARÍA GUIENAGATI', 18, 1);
CALL insert_municipality('SANTA MARÍA HUATULCO', 18, 1);
CALL insert_municipality('SANTA MARÍA HUAZOLOTITLÁN', 18, 1);
CALL insert_municipality('SANTA MARÍA IPALAPA', 18, 1);
CALL insert_municipality('SANTA MARÍA IXCATLÁN', 18, 1);
CALL insert_municipality('SANTA MARÍA JACATEPEC', 18, 1);
CALL insert_municipality('SANTA MARÍA JALAPA DEL MARQUÉS', 18, 1);
CALL insert_municipality('SANTA MARÍA JALTIANGUIS', 18, 1);
CALL insert_municipality('SANTA MARÍA LACHIXÍO', 18, 1);
CALL insert_municipality('SANTA MARÍA MIXTEQUILLA', 18, 1);
CALL insert_municipality('SANTA MARÍA NATIVITAS', 18, 1);
CALL insert_municipality('SANTA MARÍA NDUAYACO', 18, 1);
CALL insert_municipality('SANTA MARÍA OZOLOTEPEC', 18, 1);
CALL insert_municipality('SANTA MARÍA PÁPALO', 18, 1);
CALL insert_municipality('SANTA MARÍA PEÑOLES', 18, 1);
CALL insert_municipality('SANTA MARÍA PETAPA', 18, 1);
CALL insert_municipality('SANTA MARÍA QUIEGOLANI', 18, 1);
CALL insert_municipality('SANTA MARÍA SOLA', 18, 1);
CALL insert_municipality('SANTA MARÍA TATALTEPEC', 18, 1);
CALL insert_municipality('SANTA MARÍA TECOMAVACA', 18, 1);
CALL insert_municipality('SANTA MARÍA TEMAXCALAPA', 18, 1);
CALL insert_municipality('SANTA MARÍA TEMAXCALTEPEC', 18, 1);
CALL insert_municipality('SANTA MARÍA TEOPOXCO', 18, 1);
CALL insert_municipality('SANTA MARÍA TEPANTLALI', 18, 1);
CALL insert_municipality('SANTA MARÍA TEXCATITLÁN', 18, 1);
CALL insert_municipality('SANTA MARÍA TLAHUITOLTEPEC', 18, 1);
CALL insert_municipality('SANTA MARÍA TLALIXTAC', 18, 1);
CALL insert_municipality('SANTA MARÍA TONAMECA', 18, 1);
CALL insert_municipality('SANTA MARÍA TOTOLAPILLA', 18, 1);
CALL insert_municipality('SANTA MARÍA XADANI', 18, 1);
CALL insert_municipality('SANTA MARÍA YALINA', 18, 1);
CALL insert_municipality('SANTA MARÍA YAVESÍA', 18, 1);
CALL insert_municipality('SANTA MARÍA YOLOTEPEC', 18, 1);
CALL insert_municipality('SANTA MARÍA YOSOYÚA', 18, 1);
CALL insert_municipality('SANTA MARÍA YUCUHITI', 18, 1);
CALL insert_municipality('SANTA MARÍA ZACATEPEC', 18, 1);
CALL insert_municipality('SANTA MARÍA ZANIZA', 18, 1);
CALL insert_municipality('SANTA MARÍA ZOQUITLÁN', 18, 1);
CALL insert_municipality('SANTIAGO AMOLTEPEC', 18, 1);
CALL insert_municipality('SANTIAGO APOALA', 18, 1);
CALL insert_municipality('SANTIAGO APÓSTOL', 18, 1);
CALL insert_municipality('SANTIAGO ASTATA', 18, 1);
CALL insert_municipality('SANTIAGO ATITLÁN', 18, 1);
CALL insert_municipality('SANTIAGO AYUQUILILLA', 18, 1);
CALL insert_municipality('SANTIAGO CACALOXTEPEC', 18, 1);
CALL insert_municipality('SANTIAGO CAMOTLÁN', 18, 1);
CALL insert_municipality('SANTIAGO COMALTEPEC', 18, 1);
CALL insert_municipality('SANTIAGO CHAZUMBA', 18, 1);
CALL insert_municipality('SANTIAGO CHOÁPAM', 18, 1);
CALL insert_municipality('SANTIAGO DEL RÍO', 18, 1);
CALL insert_municipality('SANTIAGO HUAJOLOTITLÁN', 18, 1);
CALL insert_municipality('SANTIAGO HUAUCLILLA', 18, 1);
CALL insert_municipality('SANTIAGO IHUITLÁN PLUMAS', 18, 1);
CALL insert_municipality('SANTIAGO IXCUINTEPEC', 18, 1);
CALL insert_municipality('SANTIAGO IXTAYUTLA', 18, 1);
CALL insert_municipality('SANTIAGO JAMILTEPEC', 18, 1);
CALL insert_municipality('SANTIAGO JOCOTEPEC', 18, 1);
CALL insert_municipality('SANTIAGO JUXTLAHUACA', 18, 1);
CALL insert_municipality('SANTIAGO LACHIGUIRI', 18, 1);
CALL insert_municipality('SANTIAGO LALOPA', 18, 1);
CALL insert_municipality('SANTIAGO LAOLLAGA', 18, 1);
CALL insert_municipality('SANTIAGO LAXOPA', 18, 1);
CALL insert_municipality('SANTIAGO LLANO GRANDE', 18, 1);
CALL insert_municipality('SANTIAGO MATATLÁN', 18, 1);
CALL insert_municipality('SANTIAGO MILTEPEC', 18, 1);
CALL insert_municipality('SANTIAGO MINAS', 18, 1);
CALL insert_municipality('SANTIAGO NACALTEPEC', 18, 1);
CALL insert_municipality('SANTIAGO NEJAPILLA', 18, 1);
CALL insert_municipality('SANTIAGO NUNDICHE', 18, 1);
CALL insert_municipality('SANTIAGO NUYOÓ', 18, 1);
CALL insert_municipality('SANTIAGO PINOTEPA NACIONAL', 18, 1);
CALL insert_municipality('SANTIAGO SUCHILQUITONGO', 18, 1);
CALL insert_municipality('SANTIAGO TAMAZOLA', 18, 1);
CALL insert_municipality('SANTIAGO TAPEXTLA', 18, 1);
CALL insert_municipality('VILLA TEJÚPAM DE LA UNIÓN', 18, 1);
CALL insert_municipality('SANTIAGO TENANGO', 18, 1);
CALL insert_municipality('SANTIAGO TEPETLAPA', 18, 1);
CALL insert_municipality('SANTIAGO TETEPEC', 18, 1);
CALL insert_municipality('SANTIAGO TEXCALCINGO', 18, 1);
CALL insert_municipality('SANTIAGO TEXTITLÁN', 18, 1);
CALL insert_municipality('SANTIAGO TILANTONGO', 18, 1);
CALL insert_municipality('SANTIAGO TILLO', 18, 1);
CALL insert_municipality('SANTIAGO TLAZOYALTEPEC', 18, 1);
CALL insert_municipality('SANTIAGO XANICA', 18, 1);
CALL insert_municipality('SANTIAGO XIACUÍ', 18, 1);
CALL insert_municipality('SANTIAGO YAITEPEC', 18, 1);
CALL insert_municipality('SANTIAGO YAVEO', 18, 1);
CALL insert_municipality('SANTIAGO YOLOMÉCATL', 18, 1);
CALL insert_municipality('SANTIAGO YOSONDÚA', 18, 1);
CALL insert_municipality('SANTIAGO YUCUYACHI', 18, 1);
CALL insert_municipality('SANTIAGO ZACATEPEC', 18, 1);
CALL insert_municipality('SANTIAGO ZOOCHILA', 18, 1);
CALL insert_municipality('NUEVO ZOQUIÁPAM', 18, 1);
CALL insert_municipality('SANTO DOMINGO INGENIO', 18, 1);
CALL insert_municipality('SANTO DOMINGO ALBARRADAS', 18, 1);
CALL insert_municipality('SANTO DOMINGO ARMENTA', 18, 1);
CALL insert_municipality('SANTO DOMINGO CHIHUITÁN', 18, 1);
CALL insert_municipality('SANTO DOMINGO DE MORELOS', 18, 1);
CALL insert_municipality('SANTO DOMINGO IXCATLÁN', 18, 1);
CALL insert_municipality('SANTO DOMINGO NUXAÁ', 18, 1);
CALL insert_municipality('SANTO DOMINGO OZOLOTEPEC', 18, 1);
CALL insert_municipality('SANTO DOMINGO PETAPA', 18, 1);
CALL insert_municipality('SANTO DOMINGO ROAYAGA', 18, 1);
CALL insert_municipality('SANTO DOMINGO TEHUANTEPEC', 18, 1);
CALL insert_municipality('SANTO DOMINGO TEOJOMULCO', 18, 1);
CALL insert_municipality('SANTO DOMINGO TEPUXTEPEC', 18, 1);
CALL insert_municipality('SANTO DOMINGO TLATAYÁPAM', 18, 1);
CALL insert_municipality('SANTO DOMINGO TOMALTEPEC', 18, 1);
CALL insert_municipality('SANTO DOMINGO TONALÁ', 18, 1);
CALL insert_municipality('SANTO DOMINGO TONALTEPEC', 18, 1);
CALL insert_municipality('SANTO DOMINGO XAGACÍA', 18, 1);
CALL insert_municipality('SANTO DOMINGO YANHUITLÁN', 18, 1);
CALL insert_municipality('SANTO DOMINGO YODOHINO', 18, 1);
CALL insert_municipality('SANTO DOMINGO ZANATEPEC', 18, 1);
CALL insert_municipality('SANTOS REYES NOPALA', 18, 1);
CALL insert_municipality('SANTOS REYES PÁPALO', 18, 1);
CALL insert_municipality('SANTOS REYES TEPEJILLO', 18, 1);
CALL insert_municipality('SANTOS REYES YUCUNÁ', 18, 1);
CALL insert_municipality('SANTO TOMÁS JALIEZA', 18, 1);
CALL insert_municipality('SANTO TOMÁS MAZALTEPEC', 18, 1);
CALL insert_municipality('SANTO TOMÁS OCOTEPEC', 18, 1);
CALL insert_municipality('SANTO TOMÁS TAMAZULAPAN', 18, 1);
CALL insert_municipality('SAN VICENTE COATLÁN', 18, 1);
CALL insert_municipality('SAN VICENTE LACHIXÍO', 18, 1);
CALL insert_municipality('SAN VICENTE NUÑÚ', 18, 1);
CALL insert_municipality('SILACAYOÁPAM', 18, 1);
CALL insert_municipality('SITIO DE XITLAPEHUA', 18, 1);
CALL insert_municipality('SOLEDAD ETLA', 18, 1);
CALL insert_municipality('VILLA DE TAMAZULÁPAM DEL PROGRESO', 18, 1);
CALL insert_municipality('TANETZE DE ZARAGOZA', 18, 1);
CALL insert_municipality('TANICHE', 18, 1);
CALL insert_municipality('TATALTEPEC DE VALDÉS', 18, 1);
CALL insert_municipality('TEOCOCUILCO DE MARCOS PÉREZ', 18, 1);
CALL insert_municipality('TEOTITLÁN DE FLORES MAGÓN', 18, 1);
CALL insert_municipality('TEOTITLÁN DEL VALLE', 18, 1);
CALL insert_municipality('TEOTONGO', 18, 1);
CALL insert_municipality('TEPELMEME VILLA DE MORELOS', 18, 1);
CALL insert_municipality('VILLA TEZOATLÁN DE SEGURA Y LUNA', 18, 1);
CALL insert_municipality('SAN JERÓNIMO TLACOCHAHUAYA', 18, 1);
CALL insert_municipality('TLACOLULA DE MATAMOROS', 18, 1);
CALL insert_municipality('TLACOTEPEC PLUMAS', 18, 1);
CALL insert_municipality('TLALIXTAC DE CABRERA', 18, 1);
CALL insert_municipality('TOTONTEPEC VILLA DE MORELOS', 18, 1);
CALL insert_municipality('TRINIDAD ZAACHILA', 18, 1);
CALL insert_municipality('LA TRINIDAD VISTA HERMOSA', 18, 1);
CALL insert_municipality('UNIÓN HIDALGO', 18, 1);
CALL insert_municipality('VALERIO TRUJANO', 18, 1);
CALL insert_municipality('SAN JUAN BAUTISTA VALLE NACIONAL', 18, 1);
CALL insert_municipality('VILLA DÍAZ ORDAZ', 18, 1);
CALL insert_municipality('YAXE', 18, 1);
CALL insert_municipality('MAGDALENA YODOCONO DE PORFIRIO DÍAZ', 18, 1);
CALL insert_municipality('YOGANA', 18, 1);
CALL insert_municipality('YUTANDUCHI DE GUERRERO', 18, 1);
CALL insert_municipality('VILLA DE ZAACHILA', 18, 1);
CALL insert_municipality('SAN MATEO YUCUTINDOO', 18, 1);
CALL insert_municipality('ZAPOTITLÁN LAGUNAS', 18, 1);
CALL insert_municipality('ZAPOTITLÁN PALMAS', 18, 1);
CALL insert_municipality('SANTA INÉS DE ZARAGOZA', 18, 1);
CALL insert_municipality('ZIMATLÁN DE ÁLVAREZ', 18, 1);

CALL insert_state('PUEBLA', 1);
CALL insert_municipality('ACAJETE', 19, 1);
CALL insert_municipality('ACATENO', 19, 1);
CALL insert_municipality('ACATLÁN', 19, 1);
CALL insert_municipality('ACATZINGO', 19, 1);
CALL insert_municipality('ACTEOPAN', 19, 1);
CALL insert_municipality('AHUACATLÁN', 19, 1);
CALL insert_municipality('AHUATLÁN', 19, 1);
CALL insert_municipality('AHUAZOTEPEC', 19, 1);
CALL insert_municipality('AHUEHUETITLA', 19, 1);
CALL insert_municipality('AJALPAN', 19, 1);
CALL insert_municipality('ALBINO ZERTUCHE', 19, 1);
CALL insert_municipality('ALJOJUCA', 19, 1);
CALL insert_municipality('ALTEPEXI', 19, 1);
CALL insert_municipality('AMIXTLÁN', 19, 1);
CALL insert_municipality('AMOZOC', 19, 1);
CALL insert_municipality('AQUIXTLA', 19, 1);
CALL insert_municipality('ATEMPAN', 19, 1);
CALL insert_municipality('ATEXCAL', 19, 1);
CALL insert_municipality('ATLIXCO', 19, 1);
CALL insert_municipality('ATOYATEMPAN', 19, 1);
CALL insert_municipality('ATZALA', 19, 1);
CALL insert_municipality('ATZITZIHUACÁN', 19, 1);
CALL insert_municipality('ATZITZINTLA', 19, 1);
CALL insert_municipality('AXUTLA', 19, 1);
CALL insert_municipality('AYOTOXCO DE GUERRERO', 19, 1);
CALL insert_municipality('CALPAN', 19, 1);
CALL insert_municipality('CALTEPEC', 19, 1);
CALL insert_municipality('CAMOCUAUTLA', 19, 1);
CALL insert_municipality('CAXHUACAN', 19, 1);
CALL insert_municipality('COATEPEC', 19, 1);
CALL insert_municipality('COATZINGO', 19, 1);
CALL insert_municipality('COHETZALA', 19, 1);
CALL insert_municipality('COHUECAN', 19, 1);
CALL insert_municipality('CORONANGO', 19, 1);
CALL insert_municipality('COXCATLÁN', 19, 1);
CALL insert_municipality('COYOMEAPAN', 19, 1);
CALL insert_municipality('COYOTEPEC', 19, 1);
CALL insert_municipality('CUAPIAXTLA DE MADERO', 19, 1);
CALL insert_municipality('CUAUTEMPAN', 19, 1);
CALL insert_municipality('CUAUTINCHÁN', 19, 1);
CALL insert_municipality('CUAUTLANCINGO', 19, 1);
CALL insert_municipality('CUAYUCA DE ANDRADE', 19, 1);
CALL insert_municipality('CUETZALAN DEL PROGRESO', 19, 1);
CALL insert_municipality('CUYOACO', 19, 1);
CALL insert_municipality('CHALCHICOMULA DE SESMA', 19, 1);
CALL insert_municipality('CHAPULCO', 19, 1);
CALL insert_municipality('CHIAUTLA', 19, 1);
CALL insert_municipality('CHIAUTZINGO', 19, 1);
CALL insert_municipality('CHICONCUAUTLA', 19, 1);
CALL insert_municipality('CHICHIQUILA', 19, 1);
CALL insert_municipality('CHIETLA', 19, 1);
CALL insert_municipality('CHIGMECATITLÁN', 19, 1);
CALL insert_municipality('CHIGNAHUAPAN', 19, 1);
CALL insert_municipality('CHIGNAUTLA', 19, 1);
CALL insert_municipality('CHILA', 19, 1);
CALL insert_municipality('CHILA DE LA SAL', 19, 1);
CALL insert_municipality('HONEY', 19, 1);
CALL insert_municipality('CHILCHOTLA', 19, 1);
CALL insert_municipality('CHINANTLA', 19, 1);
CALL insert_municipality('DOMINGO ARENAS', 19, 1);
CALL insert_municipality('ELOXOCHITLÁN', 19, 1);
CALL insert_municipality('EPATLÁN', 19, 1);
CALL insert_municipality('ESPERANZA', 19, 1);
CALL insert_municipality('FRANCISCO Z. MENA', 19, 1);
CALL insert_municipality('GENERAL FELIPE ÁNGELES', 19, 1);
CALL insert_municipality('GUADALUPE', 19, 1);
CALL insert_municipality('GUADALUPE VICTORIA', 19, 1);
CALL insert_municipality('HERMENEGILDO GALEANA', 19, 1);
CALL insert_municipality('HUAQUECHULA', 19, 1);
CALL insert_municipality('HUATLATLAUCA', 19, 1);
CALL insert_municipality('HUAUCHINANGO', 19, 1);
CALL insert_municipality('HUEHUETLA', 19, 1);
CALL insert_municipality('HUEHUETLÁN EL CHICO', 19, 1);
CALL insert_municipality('HUEJOTZINGO', 19, 1);
CALL insert_municipality('HUEYAPAN', 19, 1);
CALL insert_municipality('HUEYTAMALCO', 19, 1);
CALL insert_municipality('HUEYTLALPAN', 19, 1);
CALL insert_municipality('HUITZILAN DE SERDÁN', 19, 1);
CALL insert_municipality('HUITZILTEPEC', 19, 1);
CALL insert_municipality('ATLEQUIZAYAN', 19, 1);
CALL insert_municipality('IXCAMILPA DE GUERRERO', 19, 1);
CALL insert_municipality('IXCAQUIXTLA', 19, 1);
CALL insert_municipality('IXTACAMAXTITLÁN', 19, 1);
CALL insert_municipality('IXTEPEC', 19, 1);
CALL insert_municipality('IZÚCAR DE MATAMOROS', 19, 1);
CALL insert_municipality('JALPAN', 19, 1);
CALL insert_municipality('JOLALPAN', 19, 1);
CALL insert_municipality('JONOTLA', 19, 1);
CALL insert_municipality('JOPALA', 19, 1);
CALL insert_municipality('JUAN C. BONILLA', 19, 1);
CALL insert_municipality('JUAN GALINDO', 19, 1);
CALL insert_municipality('JUAN N. MÉNDEZ', 19, 1);
CALL insert_municipality('LAFRAGUA', 19, 1);
CALL insert_municipality('LIBRES', 19, 1);
CALL insert_municipality('LA MAGDALENA TLATLAUQUITEPEC', 19, 1);
CALL insert_municipality('MAZAPILTEPEC DE JUÁREZ', 19, 1);
CALL insert_municipality('MIXTLA', 19, 1);
CALL insert_municipality('MOLCAXAC', 19, 1);
CALL insert_municipality('CAÑADA MORELOS', 19, 1);
CALL insert_municipality('NAUPAN', 19, 1);
CALL insert_municipality('NAUZONTLA', 19, 1);
CALL insert_municipality('NEALTICAN', 19, 1);
CALL insert_municipality('NICOLÁS BRAVO', 19, 1);
CALL insert_municipality('NOPALUCAN', 19, 1);
CALL insert_municipality('OCOTEPEC', 19, 1);
CALL insert_municipality('OCOYUCAN', 19, 1);
CALL insert_municipality('OLINTLA', 19, 1);
CALL insert_municipality('ORIENTAL', 19, 1);
CALL insert_municipality('PAHUATLÁN', 19, 1);
CALL insert_municipality('PALMAR DE BRAVO', 19, 1);
CALL insert_municipality('PANTEPEC', 19, 1);
CALL insert_municipality('PETLALCINGO', 19, 1);
CALL insert_municipality('PIAXTLA', 19, 1);
CALL insert_municipality('PUEBLA', 19, 1);
CALL insert_municipality('QUECHOLAC', 19, 1);
CALL insert_municipality('QUIMIXTLÁN', 19, 1);
CALL insert_municipality('RAFAEL LARA GRAJALES', 19, 1);
CALL insert_municipality('LOS REYES DE JUÁREZ', 19, 1);
CALL insert_municipality('SAN ANDRÉS CHOLULA', 19, 1);
CALL insert_municipality('SAN ANTONIO CAÑADA', 19, 1);
CALL insert_municipality('SAN DIEGO LA MESA TOCHIMILTZINGO', 19, 1);
CALL insert_municipality('SAN FELIPE TEOTLALCINGO', 19, 1);
CALL insert_municipality('SAN FELIPE TEPATLÁN', 19, 1);
CALL insert_municipality('SAN GABRIEL CHILAC', 19, 1);
CALL insert_municipality('SAN GREGORIO ATZOMPA', 19, 1);
CALL insert_municipality('SAN JERÓNIMO TECUANIPAN', 19, 1);
CALL insert_municipality('SAN JERÓNIMO XAYACATLÁN', 19, 1);
CALL insert_municipality('SAN JOSÉ CHIAPA', 19, 1);
CALL insert_municipality('SAN JOSÉ MIAHUATLÁN', 19, 1);
CALL insert_municipality('SAN JUAN ATENCO', 19, 1);
CALL insert_municipality('SAN JUAN ATZOMPA', 19, 1);
CALL insert_municipality('SAN MARTÍN TEXMELUCAN', 19, 1);
CALL insert_municipality('SAN MARTÍN TOTOLTEPEC', 19, 1);
CALL insert_municipality('SAN MATÍAS TLALANCALECA', 19, 1);
CALL insert_municipality('SAN MIGUEL IXITLÁN', 19, 1);
CALL insert_municipality('SAN MIGUEL XOXTLA', 19, 1);
CALL insert_municipality('SAN NICOLÁS BUENOS AIRES', 19, 1);
CALL insert_municipality('SAN NICOLÁS DE LOS RANCHOS', 19, 1);
CALL insert_municipality('SAN PABLO ANICANO', 19, 1);
CALL insert_municipality('SAN PEDRO CHOLULA', 19, 1);
CALL insert_municipality('SAN PEDRO YELOIXTLAHUACA', 19, 1);
CALL insert_municipality('SAN SALVADOR EL SECO', 19, 1);
CALL insert_municipality('SAN SALVADOR EL VERDE', 19, 1);
CALL insert_municipality('SAN SALVADOR HUIXCOLOTLA', 19, 1);
CALL insert_municipality('SAN SEBASTIÁN TLACOTEPEC', 19, 1);
CALL insert_municipality('SANTA CATARINA TLALTEMPAN', 19, 1);
CALL insert_municipality('SANTA INÉS AHUATEMPAN', 19, 1);
CALL insert_municipality('SANTA ISABEL CHOLULA', 19, 1);
CALL insert_municipality('SANTIAGO MIAHUATLÁN', 19, 1);
CALL insert_municipality('HUEHUETLÁN EL GRANDE', 19, 1);
CALL insert_municipality('SANTO TOMÁS HUEYOTLIPAN', 19, 1);
CALL insert_municipality('SOLTEPEC', 19, 1);
CALL insert_municipality('TECALI DE HERRERA', 19, 1);
CALL insert_municipality('TECAMACHALCO', 19, 1);
CALL insert_municipality('TECOMATLÁN', 19, 1);
CALL insert_municipality('TEHUACÁN', 19, 1);
CALL insert_municipality('TEHUITZINGO', 19, 1);
CALL insert_municipality('TENAMPULCO', 19, 1);
CALL insert_municipality('TEOPANTLÁN', 19, 1);
CALL insert_municipality('TEOTLALCO', 19, 1);
CALL insert_municipality('TEPANCO DE LÓPEZ', 19, 1);
CALL insert_municipality('TEPANGO DE RODRÍGUEZ', 19, 1);
CALL insert_municipality('TEPATLAXCO DE HIDALGO', 19, 1);
CALL insert_municipality('TEPEACA', 19, 1);
CALL insert_municipality('TEPEMAXALCO', 19, 1);
CALL insert_municipality('TEPEOJUMA', 19, 1);
CALL insert_municipality('TEPETZINTLA', 19, 1);
CALL insert_municipality('TEPEXCO', 19, 1);
CALL insert_municipality('TEPEXI DE RODRÍGUEZ', 19, 1);
CALL insert_municipality('TEPEYAHUALCO', 19, 1);
CALL insert_municipality('TEPEYAHUALCO DE CUAUHTÉMOC', 19, 1);
CALL insert_municipality('TETELA DE OCAMPO', 19, 1);
CALL insert_municipality('TETELES DE AVILA CASTILLO', 19, 1);
CALL insert_municipality('TEZIUTLÁN', 19, 1);
CALL insert_municipality('TIANGUISMANALCO', 19, 1);
CALL insert_municipality('TILAPA', 19, 1);
CALL insert_municipality('TLACOTEPEC DE BENITO JUÁREZ', 19, 1);
CALL insert_municipality('TLACUILOTEPEC', 19, 1);
CALL insert_municipality('TLACHICHUCA', 19, 1);
CALL insert_municipality('TLAHUAPAN', 19, 1);
CALL insert_municipality('TLALTENANGO', 19, 1);
CALL insert_municipality('TLANEPANTLA', 19, 1);
CALL insert_municipality('TLAOLA', 19, 1);
CALL insert_municipality('TLAPACOYA', 19, 1);
CALL insert_municipality('TLAPANALÁ', 19, 1);
CALL insert_municipality('TLATLAUQUITEPEC', 19, 1);
CALL insert_municipality('TLAXCO', 19, 1);
CALL insert_municipality('TOCHIMILCO', 19, 1);
CALL insert_municipality('TOCHTEPEC', 19, 1);
CALL insert_municipality('TOTOLTEPEC DE GUERRERO', 19, 1);
CALL insert_municipality('TULCINGO', 19, 1);
CALL insert_municipality('TUZAMAPAN DE GALEANA', 19, 1);
CALL insert_municipality('TZICATLACOYAN', 19, 1);
CALL insert_municipality('VENUSTIANO CARRANZA', 19, 1);
CALL insert_municipality('VICENTE GUERRERO', 19, 1);
CALL insert_municipality('XAYACATLÁN DE BRAVO', 19, 1);
CALL insert_municipality('XICOTEPEC', 19, 1);
CALL insert_municipality('XICOTLÁN', 19, 1);
CALL insert_municipality('XIUTETELCO', 19, 1);
CALL insert_municipality('XOCHIAPULCO', 19, 1);
CALL insert_municipality('XOCHILTEPEC', 19, 1);
CALL insert_municipality('XOCHITLÁN DE VICENTE SUÁREZ', 19, 1);
CALL insert_municipality('XOCHITLÁN TODOS SANTOS', 19, 1);
CALL insert_municipality('YAONÁHUAC', 19, 1);
CALL insert_municipality('YEHUALTEPEC', 19, 1);
CALL insert_municipality('ZACAPALA', 19, 1);
CALL insert_municipality('ZACAPOAXTLA', 19, 1);
CALL insert_municipality('ZACATLÁN', 19, 1);
CALL insert_municipality('ZAPOTITLÁN', 19, 1);
CALL insert_municipality('ZAPOTITLÁN DE MÉNDEZ', 19, 1);
CALL insert_municipality('ZARAGOZA', 19, 1);
CALL insert_municipality('ZAUTLA', 19, 1);
CALL insert_municipality('ZIHUATEUTLA', 19, 1);
CALL insert_municipality('ZINACATEPEC', 19, 1);
CALL insert_municipality('ZONGOZOTLA', 19, 1);
CALL insert_municipality('ZOQUIAPAN', 19, 1);
CALL insert_municipality('ZOQUITLÁN', 19, 1);
CALL insert_municipality('QUERÉTARO', 19, 1);
CALL insert_municipality('AMEALCO DE BONFIL', 19, 1);
CALL insert_municipality('PINAL DE AMOLES', 19, 1);
CALL insert_municipality('ARROYO SECO', 19, 1);
CALL insert_municipality('CADEREYTA DE MONTES', 19, 1);
CALL insert_municipality('COLÓN', 19, 1);
CALL insert_municipality('CORREGIDORA', 19, 1);
CALL insert_municipality('EZEQUIEL MONTES', 19, 1);
CALL insert_municipality('HUIMILPAN', 19, 1);
CALL insert_municipality('JALPAN DE SERRA', 19, 1);
CALL insert_municipality('LANDA DE MATAMOROS', 19, 1);
CALL insert_municipality('EL MARQUÉS', 19, 1);
CALL insert_municipality('PEDRO ESCOBEDO', 19, 1);
CALL insert_municipality('PEÑAMILLER', 19, 1);
CALL insert_municipality('QUERÉTARO', 19, 1);
CALL insert_municipality('SAN JOAQUÍN', 19, 1);
CALL insert_municipality('SAN JUAN DEL RÍO', 19, 1);
CALL insert_municipality('TEQUISQUIAPAN', 19, 1);
CALL insert_municipality('TOLIMÁN', 19, 1);

CALL insert_state('QUINTANA ROO', 1);
CALL insert_municipality('COZUMEL', 20, 1);
CALL insert_municipality('FELIPE CARRILLO PUERTO', 20, 1);
CALL insert_municipality('ISLA MUJERES', 20, 1);
CALL insert_municipality('OTHÓN P. BLANCO', 20, 1);
CALL insert_municipality('BENITO JUÁREZ', 20, 1);
CALL insert_municipality('JOSÉ MARÍA MORELOS', 20, 1);
CALL insert_municipality('LÁZARO CÁRDENAS', 20, 1);
CALL insert_municipality('SOLIDARIDAD', 20, 1);
CALL insert_municipality('TULUM', 20, 1);
CALL insert_municipality('BACALAR', 20, 1);
CALL insert_municipality('PUERTO MORELOS', 20, 1);
CALL insert_municipality('SAN LUIS POTOSÍ', 20, 1);
CALL insert_municipality('AHUALULCO', 20, 1);
CALL insert_municipality('ALAQUINES', 20, 1);
CALL insert_municipality('AQUISMÓN', 20, 1);
CALL insert_municipality('ARMADILLO DE LOS INFANTE', 20, 1);
CALL insert_municipality('CÁRDENAS', 20, 1);
CALL insert_municipality('CATORCE', 20, 1);
CALL insert_municipality('CEDRAL', 20, 1);
CALL insert_municipality('CERRITOS', 20, 1);
CALL insert_municipality('CERRO DE SAN PEDRO', 20, 1);
CALL insert_municipality('CIUDAD DEL MAÍZ', 20, 1);
CALL insert_municipality('CIUDAD FERNÁNDEZ', 20, 1);
CALL insert_municipality('TANCANHUITZ', 20, 1);
CALL insert_municipality('CIUDAD VALLES', 20, 1);
CALL insert_municipality('COXCATLÁN', 20, 1);
CALL insert_municipality('CHARCAS', 20, 1);
CALL insert_municipality('EBANO', 20, 1);
CALL insert_municipality('GUADALCÁZAR', 20, 1);
CALL insert_municipality('HUEHUETLÁN', 20, 1);
CALL insert_municipality('LAGUNILLAS', 20, 1);
CALL insert_municipality('MATEHUALA', 20, 1);
CALL insert_municipality('MEXQUITIC DE CARMONA', 20, 1);
CALL insert_municipality('MOCTEZUMA', 20, 1);
CALL insert_municipality('RAYÓN', 20, 1);
CALL insert_municipality('RIOVERDE', 20, 1);
CALL insert_municipality('SALINAS', 20, 1);
CALL insert_municipality('SAN ANTONIO', 20, 1);
CALL insert_municipality('SAN CIRO DE ACOSTA', 20, 1);
CALL insert_municipality('SAN LUIS POTOSÍ', 20, 1);
CALL insert_municipality('SAN MARTÍN CHALCHICUAUTLA', 20, 1);
CALL insert_municipality('SAN NICOLÁS TOLENTINO', 20, 1);
CALL insert_municipality('SANTA CATARINA', 20, 1);
CALL insert_municipality('SANTA MARÍA DEL RÍO', 20, 1);
CALL insert_municipality('SANTO DOMINGO', 20, 1);
CALL insert_municipality('SAN VICENTE TANCUAYALAB', 20, 1);
CALL insert_municipality('SOLEDAD DE GRACIANO SÁNCHEZ', 20, 1);
CALL insert_municipality('TAMASOPO', 20, 1);
CALL insert_municipality('TAMAZUNCHALE', 20, 1);
CALL insert_municipality('TAMPACÁN', 20, 1);
CALL insert_municipality('TAMPAMOLÓN CORONA', 20, 1);
CALL insert_municipality('TAMUÍN', 20, 1);
CALL insert_municipality('TANLAJÁS', 20, 1);
CALL insert_municipality('TANQUIÁN DE ESCOBEDO', 20, 1);
CALL insert_municipality('TIERRA NUEVA', 20, 1);
CALL insert_municipality('VANEGAS', 20, 1);
CALL insert_municipality('VENADO', 20, 1);
CALL insert_municipality('VILLA DE ARRIAGA', 20, 1);
CALL insert_municipality('VILLA DE GUADALUPE', 20, 1);
CALL insert_municipality('VILLA DE LA PAZ', 20, 1);
CALL insert_municipality('VILLA DE RAMOS', 20, 1);
CALL insert_municipality('VILLA DE REYES', 20, 1);
CALL insert_municipality('VILLA HIDALGO', 20, 1);
CALL insert_municipality('VILLA JUÁREZ', 20, 1);
CALL insert_municipality('AXTLA DE TERRAZAS', 20, 1);
CALL insert_municipality('XILITLA', 20, 1);
CALL insert_municipality('ZARAGOZA', 20, 1);
CALL insert_municipality('VILLA DE ARISTA', 20, 1);
CALL insert_municipality('MATLAPA', 20, 1);
CALL insert_municipality('EL NARANJO', 20, 1);

CALL insert_state('SINALOA', 1);
CALL insert_municipality('AHOME', 21, 1);
CALL insert_municipality('ANGOSTURA', 21, 1);
CALL insert_municipality('BADIRAGUATO', 21, 1);
CALL insert_municipality('CONCORDIA', 21, 1);
CALL insert_municipality('COSALÁ', 21, 1);
CALL insert_municipality('CULIACÁN', 21, 1);
CALL insert_municipality('CHOIX', 21, 1);
CALL insert_municipality('ELOTA', 21, 1);
CALL insert_municipality('ESCUINAPA', 21, 1);
CALL insert_municipality('EL FUERTE', 21, 1);
CALL insert_municipality('GUASAVE', 21, 1);
CALL insert_municipality('MAZATLÁN', 21, 1);
CALL insert_municipality('MOCORITO', 21, 1);
CALL insert_municipality('ROSARIO', 21, 1);
CALL insert_municipality('SALVADOR ALVARADO', 21, 1);
CALL insert_municipality('SAN IGNACIO', 21, 1);
CALL insert_municipality('SINALOA', 21, 1);
CALL insert_municipality('NAVOLATO', 21, 1);
CALL insert_municipality('SONORA', 21, 1);
CALL insert_municipality('ACONCHI', 21, 1);
CALL insert_municipality('AGUA PRIETA', 21, 1);
CALL insert_municipality('ALAMOS', 21, 1);
CALL insert_municipality('ALTAR', 21, 1);
CALL insert_municipality('ARIVECHI', 21, 1);
CALL insert_municipality('ARIZPE', 21, 1);
CALL insert_municipality('ATIL', 21, 1);
CALL insert_municipality('BACADÉHUACHI', 21, 1);
CALL insert_municipality('BACANORA', 21, 1);
CALL insert_municipality('BACERAC', 21, 1);
CALL insert_municipality('BACOACHI', 21, 1);
CALL insert_municipality('BÁCUM', 21, 1);
CALL insert_municipality('BANÁMICHI', 21, 1);
CALL insert_municipality('BAVIÁCORA', 21, 1);
CALL insert_municipality('BAVISPE', 21, 1);
CALL insert_municipality('BENJAMÍN HILL', 21, 1);
CALL insert_municipality('CABORCA', 21, 1);
CALL insert_municipality('CAJEME', 21, 1);
CALL insert_municipality('CANANEA', 21, 1);
CALL insert_municipality('CARBÓ', 21, 1);
CALL insert_municipality('LA COLORADA', 21, 1);
CALL insert_municipality('CUCURPE', 21, 1);
CALL insert_municipality('CUMPAS', 21, 1);
CALL insert_municipality('DIVISADEROS', 21, 1);
CALL insert_municipality('EMPALME', 21, 1);
CALL insert_municipality('ETCHOJOA', 21, 1);
CALL insert_municipality('FRONTERAS', 21, 1);
CALL insert_municipality('GRANADOS', 21, 1);
CALL insert_municipality('GUAYMAS', 21, 1);
CALL insert_municipality('HERMOSILLO', 21, 1);
CALL insert_municipality('HUACHINERA', 21, 1);
CALL insert_municipality('HUÁSABAS', 21, 1);
CALL insert_municipality('HUATABAMPO', 21, 1);
CALL insert_municipality('HUÉPAC', 21, 1);
CALL insert_municipality('IMURIS', 21, 1);
CALL insert_municipality('MAGDALENA', 21, 1);
CALL insert_municipality('MAZATÁN', 21, 1);
CALL insert_municipality('MOCTEZUMA', 21, 1);
CALL insert_municipality('NACO', 21, 1);
CALL insert_municipality('NÁCORI CHICO', 21, 1);
CALL insert_municipality('NACOZARI DE GARCÍA', 21, 1);
CALL insert_municipality('NAVOJOA', 21, 1);
CALL insert_municipality('NOGALES', 21, 1);
CALL insert_municipality('ONAVAS', 21, 1);
CALL insert_municipality('OPODEPE', 21, 1);
CALL insert_municipality('OQUITOA', 21, 1);
CALL insert_municipality('PITIQUITO', 21, 1);
CALL insert_municipality('PUERTO PEÑASCO', 21, 1);
CALL insert_municipality('QUIRIEGO', 21, 1);
CALL insert_municipality('RAYÓN', 21, 1);
CALL insert_municipality('ROSARIO', 21, 1);
CALL insert_municipality('SAHUARIPA', 21, 1);
CALL insert_municipality('SAN FELIPE DE JESÚS', 21, 1);
CALL insert_municipality('SAN JAVIER', 21, 1);
CALL insert_municipality('SAN LUIS RÍO COLORADO', 21, 1);
CALL insert_municipality('SAN MIGUEL DE HORCASITAS', 21, 1);
CALL insert_municipality('SAN PEDRO DE LA CUEVA', 21, 1);
CALL insert_municipality('SANTA ANA', 21, 1);
CALL insert_municipality('SANTA CRUZ', 21, 1);
CALL insert_municipality('SÁRIC', 21, 1);
CALL insert_municipality('SOYOPA', 21, 1);
CALL insert_municipality('SUAQUI GRANDE', 21, 1);
CALL insert_municipality('TEPACHE', 21, 1);
CALL insert_municipality('TRINCHERAS', 21, 1);
CALL insert_municipality('TUBUTAMA', 21, 1);
CALL insert_municipality('URES', 21, 1);
CALL insert_municipality('VILLA HIDALGO', 21, 1);
CALL insert_municipality('VILLA PESQUEIRA', 21, 1);
CALL insert_municipality('YÉCORA', 21, 1);
CALL insert_municipality('GENERAL PLUTARCO ELÍAS CALLES', 21, 1);
CALL insert_municipality('BENITO JUÁREZ', 21, 1);
CALL insert_municipality('SAN IGNACIO RÍO MUERTO', 21, 1);

CALL insert_state('TABASCO', 1);
CALL insert_municipality('BALANCÁN', 22, 1);
CALL insert_municipality('CÁRDENAS', 22, 1);
CALL insert_municipality('CENTLA', 22, 1);
CALL insert_municipality('CENTRO', 22, 1);
CALL insert_municipality('COMALCALCO', 22, 1);
CALL insert_municipality('CUNDUACÁN', 22, 1);
CALL insert_municipality('EMILIANO ZAPATA', 22, 1);
CALL insert_municipality('HUIMANGUILLO', 22, 1);
CALL insert_municipality('JALAPA', 22, 1);
CALL insert_municipality('JALPA DE MÉNDEZ', 22, 1);
CALL insert_municipality('JONUTA', 22, 1);
CALL insert_municipality('MACUSPANA', 22, 1);
CALL insert_municipality('NACAJUCA', 22, 1);
CALL insert_municipality('PARAÍSO', 22, 1);
CALL insert_municipality('TACOTALPA', 22, 1);
CALL insert_municipality('TEAPA', 22, 1);
CALL insert_municipality('TENOSIQUE', 22, 1);

CALL insert_state('TAMAULIPAS', 1);
CALL insert_municipality('ABASOLO', 23, 1);
CALL insert_municipality('ALDAMA', 23, 1);
CALL insert_municipality('ALTAMIRA', 23, 1);
CALL insert_municipality('ANTIGUO MORELOS', 23, 1);
CALL insert_municipality('BURGOS', 23, 1);
CALL insert_municipality('BUSTAMANTE', 23, 1);
CALL insert_municipality('CAMARGO', 23, 1);
CALL insert_municipality('CASAS', 23, 1);
CALL insert_municipality('CIUDAD MADERO', 23, 1);
CALL insert_municipality('CRUILLAS', 23, 1);
CALL insert_municipality('GÓMEZ FARÍAS', 23, 1);
CALL insert_municipality('GONZÁLEZ', 23, 1);
CALL insert_municipality('GÜÉMEZ', 23, 1);
CALL insert_municipality('GUERRERO', 23, 1);
CALL insert_municipality('GUSTAVO DÍAZ ORDAZ', 23, 1);
CALL insert_municipality('HIDALGO', 23, 1);
CALL insert_municipality('JAUMAVE', 23, 1);
CALL insert_municipality('JIMÉNEZ', 23, 1);
CALL insert_municipality('LLERA', 23, 1);
CALL insert_municipality('MAINERO', 23, 1);
CALL insert_municipality('EL MANTE', 23, 1);
CALL insert_municipality('MATAMOROS', 23, 1);
CALL insert_municipality('MÉNDEZ', 23, 1);
CALL insert_municipality('MIER', 23, 1);
CALL insert_municipality('MIGUEL ALEMÁN', 23, 1);
CALL insert_municipality('MIQUIHUANA', 23, 1);
CALL insert_municipality('NUEVO LAREDO', 23, 1);
CALL insert_municipality('NUEVO MORELOS', 23, 1);
CALL insert_municipality('OCAMPO', 23, 1);
CALL insert_municipality('PADILLA', 23, 1);
CALL insert_municipality('PALMILLAS', 23, 1);
CALL insert_municipality('REYNOSA', 23, 1);
CALL insert_municipality('RÍO BRAVO', 23, 1);
CALL insert_municipality('SAN CARLOS', 23, 1);
CALL insert_municipality('SAN FERNANDO', 23, 1);
CALL insert_municipality('SAN NICOLÁS', 23, 1);
CALL insert_municipality('SOTO LA MARINA', 23, 1);
CALL insert_municipality('TAMPICO', 23, 1);
CALL insert_municipality('TULA', 23, 1);
CALL insert_municipality('VALLE HERMOSO', 23, 1);
CALL insert_municipality('VICTORIA', 23, 1);
CALL insert_municipality('VILLAGRÁN', 23, 1);
CALL insert_municipality('XICOTÉNCATL', 23, 1);

CALL insert_state('TLAXCALA', 1);
CALL insert_municipality('AMAXAC DE GUERRERO', 24, 1);
CALL insert_municipality('APETATITLÁN DE ANTONIO CARVAJAL', 24, 1);
CALL insert_municipality('ATLANGATEPEC', 24, 1);
CALL insert_municipality('ATLTZAYANCA', 24, 1);
CALL insert_municipality('APIZACO', 24, 1);
CALL insert_municipality('CALPULALPAN', 24, 1);
CALL insert_municipality('EL CARMEN TEQUEXQUITLA', 24, 1);
CALL insert_municipality('CUAPIAXTLA', 24, 1);
CALL insert_municipality('CUAXOMULCO', 24, 1);
CALL insert_municipality('CHIAUTEMPAN', 24, 1);
CALL insert_municipality('MUÑOZ DE DOMINGO ARENAS', 24, 1);
CALL insert_municipality('ESPAÑITA', 24, 1);
CALL insert_municipality('HUAMANTLA', 24, 1);
CALL insert_municipality('HUEYOTLIPAN', 24, 1);
CALL insert_municipality('IXTACUIXTLA DE MARIANO MATAMOROS', 24, 1);
CALL insert_municipality('IXTENCO', 24, 1);
CALL insert_municipality('MAZATECOCHCO DE JOSÉ MARÍA MORELOS', 24, 1);
CALL insert_municipality('CONTLA DE JUAN CUAMATZI', 24, 1);
CALL insert_municipality('TEPETITLA DE LARDIZÁBAL', 24, 1);
CALL insert_municipality('SANCTÓRUM DE LÁZARO CÁRDENAS', 24, 1);
CALL insert_municipality('NANACAMILPA DE MARIANO ARISTA', 24, 1);
CALL insert_municipality('ACUAMANALA DE MIGUEL HIDALGO', 24, 1);
CALL insert_municipality('NATÍVITAS', 24, 1);
CALL insert_municipality('PANOTLA', 24, 1);
CALL insert_municipality('SAN PABLO DEL MONTE', 24, 1);
CALL insert_municipality('SANTA CRUZ TLAXCALA', 24, 1);
CALL insert_municipality('TENANCINGO', 24, 1);
CALL insert_municipality('TEOLOCHOLCO', 24, 1);
CALL insert_municipality('TEPEYANCO', 24, 1);
CALL insert_municipality('TERRENATE', 24, 1);
CALL insert_municipality('TETLA DE LA SOLIDARIDAD', 24, 1);
CALL insert_municipality('TETLATLAHUCA', 24, 1);
CALL insert_municipality('TLAXCALA', 24, 1);
CALL insert_municipality('TLAXCO', 24, 1);
CALL insert_municipality('TOCATLÁN', 24, 1);
CALL insert_municipality('TOTOLAC', 24, 1);
CALL insert_municipality('ZILTLALTÉPEC DE TRINIDAD SÁNCHEZ SANTOS', 24, 1);
CALL insert_municipality('TZOMPANTEPEC', 24, 1);
CALL insert_municipality('XALOZTOC', 24, 1);
CALL insert_municipality('XALTOCAN', 24, 1);
CALL insert_municipality('PAPALOTLA DE XICOHTÉNCATL', 24, 1);
CALL insert_municipality('XICOHTZINCO', 24, 1);
CALL insert_municipality('YAUHQUEMEHCAN', 24, 1);
CALL insert_municipality('ZACATELCO', 24, 1);
CALL insert_municipality('BENITO JUÁREZ', 24, 1);
CALL insert_municipality('EMILIANO ZAPATA', 24, 1);
CALL insert_municipality('LÁZARO CÁRDENAS', 24, 1);
CALL insert_municipality('LA MAGDALENA TLALTELULCO', 24, 1);
CALL insert_municipality('SAN DAMIÁN TEXÓLOC', 24, 1);
CALL insert_municipality('SAN FRANCISCO TETLANOHCAN', 24, 1);
CALL insert_municipality('SAN JERÓNIMO ZACUALPAN', 24, 1);
CALL insert_municipality('SAN JOSÉ TEACALCO', 24, 1);
CALL insert_municipality('SAN JUAN HUACTZINCO', 24, 1);
CALL insert_municipality('SAN LORENZO AXOCOMANITLA', 24, 1);
CALL insert_municipality('SAN LUCAS TECOPILCO', 24, 1);
CALL insert_municipality('SANTA ANA NOPALUCAN', 24, 1);
CALL insert_municipality('SANTA APOLONIA TEACALCO', 24, 1);
CALL insert_municipality('SANTA CATARINA AYOMETLA', 24, 1);
CALL insert_municipality('SANTA CRUZ QUILEHTLA', 24, 1);
CALL insert_municipality('SANTA ISABEL XILOXOXTLA', 24, 1);

CALL insert_state('VERACRUZ', 1);
CALL insert_municipality('ACAJETE', 25, 1);
CALL insert_municipality('ACATLÁN', 25, 1);
CALL insert_municipality('ACAYUCAN', 25, 1);
CALL insert_municipality('ACTOPAN', 25, 1);
CALL insert_municipality('ACULA', 25, 1);
CALL insert_municipality('ACULTZINGO', 25, 1);
CALL insert_municipality('CAMARÓN DE TEJEDA', 25, 1);
CALL insert_municipality('ALPATLÁHUAC', 25, 1);
CALL insert_municipality('ALTO LUCERO DE GUTIÉRREZ BARRIOS', 25, 1);
CALL insert_municipality('ALTOTONGA', 25, 1);
CALL insert_municipality('ALVARADO', 25, 1);
CALL insert_municipality('AMATITLÁN', 25, 1);
CALL insert_municipality('NARANJOS AMATLÁN', 25, 1);
CALL insert_municipality('AMATLÁN DE LOS REYES', 25, 1);
CALL insert_municipality('ANGEL R. CABADA', 25, 1);
CALL insert_municipality('LA ANTIGUA', 25, 1);
CALL insert_municipality('APAZAPAN', 25, 1);
CALL insert_municipality('AQUILA', 25, 1);
CALL insert_municipality('ASTACINGA', 25, 1);
CALL insert_municipality('ATLAHUILCO', 25, 1);
CALL insert_municipality('ATOYAC', 25, 1);
CALL insert_municipality('ATZACAN', 25, 1);
CALL insert_municipality('ATZALAN', 25, 1);
CALL insert_municipality('TLALTETELA', 25, 1);
CALL insert_municipality('AYAHUALULCO', 25, 1);
CALL insert_municipality('BANDERILLA', 25, 1);
CALL insert_municipality('BENITO JUÁREZ', 25, 1);
CALL insert_municipality('BOCA DEL RÍO', 25, 1);
CALL insert_municipality('CALCAHUALCO', 25, 1);
CALL insert_municipality('CAMERINO Z. MENDOZA', 25, 1);
CALL insert_municipality('CARRILLO PUERTO', 25, 1);
CALL insert_municipality('CATEMACO', 25, 1);
CALL insert_municipality('CAZONES DE HERRERA', 25, 1);
CALL insert_municipality('CERRO AZUL', 25, 1);
CALL insert_municipality('CITLALTÉPETL', 25, 1);
CALL insert_municipality('COACOATZINTLA', 25, 1);
CALL insert_municipality('COAHUITLÁN', 25, 1);
CALL insert_municipality('COATEPEC', 25, 1);
CALL insert_municipality('COATZACOALCOS', 25, 1);
CALL insert_municipality('COATZINTLA', 25, 1);
CALL insert_municipality('COETZALA', 25, 1);
CALL insert_municipality('COLIPA', 25, 1);
CALL insert_municipality('COMAPA', 25, 1);
CALL insert_municipality('CÓRDOBA', 25, 1);
CALL insert_municipality('COSAMALOAPAN DE CARPIO', 25, 1);
CALL insert_municipality('COSAUTLÁN DE CARVAJAL', 25, 1);
CALL insert_municipality('COSCOMATEPEC', 25, 1);
CALL insert_municipality('COSOLEACAQUE', 25, 1);
CALL insert_municipality('COTAXTLA', 25, 1);
CALL insert_municipality('COXQUIHUI', 25, 1);
CALL insert_municipality('COYUTLA', 25, 1);
CALL insert_municipality('CUICHAPA', 25, 1);
CALL insert_municipality('CUITLÁHUAC', 25, 1);
CALL insert_municipality('CHACALTIANGUIS', 25, 1);
CALL insert_municipality('CHALMA', 25, 1);
CALL insert_municipality('CHICONAMEL', 25, 1);
CALL insert_municipality('CHICONQUIACO', 25, 1);
CALL insert_municipality('CHICONTEPEC', 25, 1);
CALL insert_municipality('CHINAMECA', 25, 1);
CALL insert_municipality('CHINAMPA DE GOROSTIZA', 25, 1);
CALL insert_municipality('LAS CHOAPAS', 25, 1);
CALL insert_municipality('CHOCAMÁN', 25, 1);
CALL insert_municipality('CHONTLA', 25, 1);
CALL insert_municipality('CHUMATLÁN', 25, 1);
CALL insert_municipality('EMILIANO ZAPATA', 25, 1);
CALL insert_municipality('ESPINAL', 25, 1);
CALL insert_municipality('FILOMENO MATA', 25, 1);
CALL insert_municipality('FORTÍN', 25, 1);
CALL insert_municipality('GUTIÉRREZ ZAMORA', 25, 1);
CALL insert_municipality('HIDALGOTITLÁN', 25, 1);
CALL insert_municipality('HUATUSCO', 25, 1);
CALL insert_municipality('HUAYACOCOTLA', 25, 1);
CALL insert_municipality('HUEYAPAN DE OCAMPO', 25, 1);
CALL insert_municipality('HUILOAPAN DE CUAUHTÉMOC', 25, 1);
CALL insert_municipality('IGNACIO DE LA LLAVE', 25, 1);
CALL insert_municipality('ILAMATLÁN', 25, 1);
CALL insert_municipality('ISLA', 25, 1);
CALL insert_municipality('IXCATEPEC', 25, 1);
CALL insert_municipality('IXHUACÁN DE LOS REYES', 25, 1);
CALL insert_municipality('IXHUATLÁN DEL CAFÉ', 25, 1);
CALL insert_municipality('IXHUATLANCILLO', 25, 1);
CALL insert_municipality('IXHUATLÁN DEL SURESTE', 25, 1);
CALL insert_municipality('IXHUATLÁN DE MADERO', 25, 1);
CALL insert_municipality('IXMATLAHUACAN', 25, 1);
CALL insert_municipality('IXTACZOQUITLÁN', 25, 1);
CALL insert_municipality('JALACINGO', 25, 1);
CALL insert_municipality('XALAPA', 25, 1);
CALL insert_municipality('JALCOMULCO', 25, 1);
CALL insert_municipality('JÁLTIPAN', 25, 1);
CALL insert_municipality('JAMAPA', 25, 1);
CALL insert_municipality('JESÚS CARRANZA', 25, 1);
CALL insert_municipality('XICO', 25, 1);
CALL insert_municipality('JILOTEPEC', 25, 1);
CALL insert_municipality('JUAN RODRÍGUEZ CLARA', 25, 1);
CALL insert_municipality('JUCHIQUE DE FERRER', 25, 1);
CALL insert_municipality('LANDERO Y COSS', 25, 1);
CALL insert_municipality('LERDO DE TEJADA', 25, 1);
CALL insert_municipality('MAGDALENA', 25, 1);
CALL insert_municipality('MALTRATA', 25, 1);
CALL insert_municipality('MANLIO FABIO ALTAMIRANO', 25, 1);
CALL insert_municipality('MARIANO ESCOBEDO', 25, 1);
CALL insert_municipality('MARTÍNEZ DE LA TORRE', 25, 1);
CALL insert_municipality('MECATLÁN', 25, 1);
CALL insert_municipality('MECAYAPAN', 25, 1);
CALL insert_municipality('MEDELLÍN DE BRAVO', 25, 1);
CALL insert_municipality('MIAHUATLÁN', 25, 1);
CALL insert_municipality('LAS MINAS', 25, 1);
CALL insert_municipality('MINATITLÁN', 25, 1);
CALL insert_municipality('MISANTLA', 25, 1);
CALL insert_municipality('MIXTLA DE ALTAMIRANO', 25, 1);
CALL insert_municipality('MOLOACÁN', 25, 1);
CALL insert_municipality('NAOLINCO', 25, 1);
CALL insert_municipality('NARANJAL', 25, 1);
CALL insert_municipality('NAUTLA', 25, 1);
CALL insert_municipality('NOGALES', 25, 1);
CALL insert_municipality('OLUTA', 25, 1);
CALL insert_municipality('OMEALCA', 25, 1);
CALL insert_municipality('ORIZABA', 25, 1);
CALL insert_municipality('OTATITLÁN', 25, 1);
CALL insert_municipality('OTEAPAN', 25, 1);
CALL insert_municipality('OZULUAMA DE MASCAREÑAS', 25, 1);
CALL insert_municipality('PAJAPAN', 25, 1);
CALL insert_municipality('PÁNUCO', 25, 1);
CALL insert_municipality('PAPANTLA', 25, 1);
CALL insert_municipality('PASO DEL MACHO', 25, 1);
CALL insert_municipality('PASO DE OVEJAS', 25, 1);
CALL insert_municipality('LA PERLA', 25, 1);
CALL insert_municipality('PEROTE', 25, 1);
CALL insert_municipality('PLATÓN SÁNCHEZ', 25, 1);
CALL insert_municipality('PLAYA VICENTE', 25, 1);
CALL insert_municipality('POZA RICA DE HIDALGO', 25, 1);
CALL insert_municipality('LAS VIGAS DE RAMÍREZ', 25, 1);
CALL insert_municipality('PUEBLO VIEJO', 25, 1);
CALL insert_municipality('PUENTE NACIONAL', 25, 1);
CALL insert_municipality('RAFAEL DELGADO', 25, 1);
CALL insert_municipality('RAFAEL LUCIO', 25, 1);
CALL insert_municipality('LOS REYES', 25, 1);
CALL insert_municipality('RÍO BLANCO', 25, 1);
CALL insert_municipality('SALTABARRANCA', 25, 1);
CALL insert_municipality('SAN ANDRÉS TENEJAPAN', 25, 1);
CALL insert_municipality('SAN ANDRÉS TUXTLA', 25, 1);
CALL insert_municipality('SAN JUAN EVANGELISTA', 25, 1);
CALL insert_municipality('SANTIAGO TUXTLA', 25, 1);
CALL insert_municipality('SAYULA DE ALEMÁN', 25, 1);
CALL insert_municipality('SOCONUSCO', 25, 1);
CALL insert_municipality('SOCHIAPA', 25, 1);
CALL insert_municipality('SOLEDAD ATZOMPA', 25, 1);
CALL insert_municipality('SOLEDAD DE DOBLADO', 25, 1);
CALL insert_municipality('SOTEAPAN', 25, 1);
CALL insert_municipality('TAMALÍN', 25, 1);
CALL insert_municipality('TAMIAHUA', 25, 1);
CALL insert_municipality('TAMPICO ALTO', 25, 1);
CALL insert_municipality('TANCOCO', 25, 1);
CALL insert_municipality('TANTIMA', 25, 1);
CALL insert_municipality('TANTOYUCA', 25, 1);
CALL insert_municipality('TATATILA', 25, 1);
CALL insert_municipality('CASTILLO DE TEAYO', 25, 1);
CALL insert_municipality('TECOLUTLA', 25, 1);
CALL insert_municipality('TEHUIPANGO', 25, 1);
CALL insert_municipality('ÁLAMO TEMAPACHE', 25, 1);
CALL insert_municipality('TEMPOAL', 25, 1);
CALL insert_municipality('TENAMPA', 25, 1);
CALL insert_municipality('TENOCHTITLÁN', 25, 1);
CALL insert_municipality('TEOCELO', 25, 1);
CALL insert_municipality('TEPATLAXCO', 25, 1);
CALL insert_municipality('TEPETLÁN', 25, 1);
CALL insert_municipality('TEPETZINTLA', 25, 1);
CALL insert_municipality('TEQUILA', 25, 1);
CALL insert_municipality('JOSÉ AZUETA', 25, 1);
CALL insert_municipality('TEXCATEPEC', 25, 1);
CALL insert_municipality('TEXHUACÁN', 25, 1);
CALL insert_municipality('TEXISTEPEC', 25, 1);
CALL insert_municipality('TEZONAPA', 25, 1);
CALL insert_municipality('TIERRA BLANCA', 25, 1);
CALL insert_municipality('TIHUATLÁN', 25, 1);
CALL insert_municipality('TLACOJALPAN', 25, 1);
CALL insert_municipality('TLACOLULAN', 25, 1);
CALL insert_municipality('TLACOTALPAN', 25, 1);
CALL insert_municipality('TLACOTEPEC DE MEJÍA', 25, 1);
CALL insert_municipality('TLACHICHILCO', 25, 1);
CALL insert_municipality('TLALIXCOYAN', 25, 1);
CALL insert_municipality('TLALNELHUAYOCAN', 25, 1);
CALL insert_municipality('TLAPACOYAN', 25, 1);
CALL insert_municipality('TLAQUILPA', 25, 1);
CALL insert_municipality('TLILAPAN', 25, 1);
CALL insert_municipality('TOMATLÁN', 25, 1);
CALL insert_municipality('TONAYÁN', 25, 1);
CALL insert_municipality('TOTUTLA', 25, 1);
CALL insert_municipality('TUXPAN', 25, 1);
CALL insert_municipality('TUXTILLA', 25, 1);
CALL insert_municipality('URSULO GALVÁN', 25, 1);
CALL insert_municipality('VEGA DE ALATORRE', 25, 1);
CALL insert_municipality('VERACRUZ', 25, 1);
CALL insert_municipality('VILLA ALDAMA', 25, 1);
CALL insert_municipality('XOXOCOTLA', 25, 1);
CALL insert_municipality('YANGA', 25, 1);
CALL insert_municipality('YECUATLA', 25, 1);
CALL insert_municipality('ZACUALPAN', 25, 1);
CALL insert_municipality('ZARAGOZA', 25, 1);
CALL insert_municipality('ZENTLA', 25, 1);
CALL insert_municipality('ZONGOLICA', 25, 1);
CALL insert_municipality('ZONTECOMATLÁN DE LÓPEZ Y FUENTES', 25, 1);
CALL insert_municipality('ZOZOCOLCO DE HIDALGO', 25, 1);
CALL insert_municipality('AGUA DULCE', 25, 1);
CALL insert_municipality('EL HIGO', 25, 1);
CALL insert_municipality('NANCHITAL DE LÁZARO CÁRDENAS DEL RÍO', 25, 1);
CALL insert_municipality('TRES VALLES', 25, 1);
CALL insert_municipality('CARLOS A. CARRILLO', 25, 1);
CALL insert_municipality('TATAHUICAPAN DE JUÁREZ', 25, 1);
CALL insert_municipality('UXPANAPA', 25, 1);
CALL insert_municipality('SAN RAFAEL', 25, 1);
CALL insert_municipality('SANTIAGO SOCHIAPAN', 25, 1);

CALL insert_state('YUCATÁN', 1);
CALL insert_municipality('ABALÁ', 26, 1);
CALL insert_municipality('ACANCEH', 26, 1);
CALL insert_municipality('AKIL', 26, 1);
CALL insert_municipality('BACA', 26, 1);
CALL insert_municipality('BOKOBÁ', 26, 1);
CALL insert_municipality('BUCTZOTZ', 26, 1);
CALL insert_municipality('CACALCHÉN', 26, 1);
CALL insert_municipality('CALOTMUL', 26, 1);
CALL insert_municipality('CANSAHCAB', 26, 1);
CALL insert_municipality('CANTAMAYEC', 26, 1);
CALL insert_municipality('CELESTÚN', 26, 1);
CALL insert_municipality('CENOTILLO', 26, 1);
CALL insert_municipality('CONKAL', 26, 1);
CALL insert_municipality('CUNCUNUL', 26, 1);
CALL insert_municipality('CUZAMÁ', 26, 1);
CALL insert_municipality('CHACSINKÍN', 26, 1);
CALL insert_municipality('CHANKOM', 26, 1);
CALL insert_municipality('CHAPAB', 26, 1);
CALL insert_municipality('CHEMAX', 26, 1);
CALL insert_municipality('CHICXULUB PUEBLO', 26, 1);
CALL insert_municipality('CHICHIMILÁ', 26, 1);
CALL insert_municipality('CHIKINDZONOT', 26, 1);
CALL insert_municipality('CHOCHOLÁ', 26, 1);
CALL insert_municipality('CHUMAYEL', 26, 1);
CALL insert_municipality('DZÁN', 26, 1);
CALL insert_municipality('DZEMUL', 26, 1);
CALL insert_municipality('DZIDZANTÚN', 26, 1);
CALL insert_municipality('DZILAM DE BRAVO', 26, 1);
CALL insert_municipality('DZILAM GONZÁLEZ', 26, 1);
CALL insert_municipality('DZITÁS', 26, 1);
CALL insert_municipality('DZONCAUICH', 26, 1);
CALL insert_municipality('ESPITA', 26, 1);
CALL insert_municipality('HALACHÓ', 26, 1);
CALL insert_municipality('HOCABÁ', 26, 1);
CALL insert_municipality('HOCTÚN', 26, 1);
CALL insert_municipality('HOMÚN', 26, 1);
CALL insert_municipality('HUHÍ', 26, 1);
CALL insert_municipality('HUNUCMÁ', 26, 1);
CALL insert_municipality('IXIL', 26, 1);
CALL insert_municipality('IZAMAL', 26, 1);
CALL insert_municipality('KANASÍN', 26, 1);
CALL insert_municipality('KANTUNIL', 26, 1);
CALL insert_municipality('KAUA', 26, 1);
CALL insert_municipality('KINCHIL', 26, 1);
CALL insert_municipality('KOPOMÁ', 26, 1);
CALL insert_municipality('MAMA', 26, 1);
CALL insert_municipality('MANÍ', 26, 1);
CALL insert_municipality('MAXCANÚ', 26, 1);
CALL insert_municipality('MAYAPÁN', 26, 1);
CALL insert_municipality('MÉRIDA', 26, 1);
CALL insert_municipality('MOCOCHÁ', 26, 1);
CALL insert_municipality('MOTUL', 26, 1);
CALL insert_municipality('MUNA', 26, 1);
CALL insert_municipality('MUXUPIP', 26, 1);
CALL insert_municipality('OPICHÉN', 26, 1);
CALL insert_municipality('OXKUTZCAB', 26, 1);
CALL insert_municipality('PANABÁ', 26, 1);
CALL insert_municipality('PETO', 26, 1);
CALL insert_municipality('PROGRESO', 26, 1);
CALL insert_municipality('QUINTANA ROO', 26, 1);
CALL insert_municipality('RÍO LAGARTOS', 26, 1);
CALL insert_municipality('SACALUM', 26, 1);
CALL insert_municipality('SAMAHIL', 26, 1);
CALL insert_municipality('SANAHCAT', 26, 1);
CALL insert_municipality('SAN FELIPE', 26, 1);
CALL insert_municipality('SANTA ELENA', 26, 1);
CALL insert_municipality('SEYÉ', 26, 1);
CALL insert_municipality('SINANCHÉ', 26, 1);
CALL insert_municipality('SOTUTA', 26, 1);
CALL insert_municipality('SUCILÁ', 26, 1);
CALL insert_municipality('SUDZAL', 26, 1);
CALL insert_municipality('SUMA', 26, 1);
CALL insert_municipality('TAHDZIÚ', 26, 1);
CALL insert_municipality('TAHMEK', 26, 1);
CALL insert_municipality('TEABO', 26, 1);
CALL insert_municipality('TECOH', 26, 1);
CALL insert_municipality('TEKAL DE VENEGAS', 26, 1);
CALL insert_municipality('TEKANTÓ', 26, 1);
CALL insert_municipality('TEKAX', 26, 1);
CALL insert_municipality('TEKIT', 26, 1);
CALL insert_municipality('TEKOM', 26, 1);
CALL insert_municipality('TELCHAC PUEBLO', 26, 1);
CALL insert_municipality('TELCHAC PUERTO', 26, 1);
CALL insert_municipality('TEMAX', 26, 1);
CALL insert_municipality('TEMOZÓN', 26, 1);
CALL insert_municipality('TEPAKÁN', 26, 1);
CALL insert_municipality('TETIZ', 26, 1);
CALL insert_municipality('TEYA', 26, 1);
CALL insert_municipality('TICUL', 26, 1);
CALL insert_municipality('TIMUCUY', 26, 1);
CALL insert_municipality('TINUM', 26, 1);
CALL insert_municipality('TIXCACALCUPUL', 26, 1);
CALL insert_municipality('TIXKOKOB', 26, 1);
CALL insert_municipality('TIXMEHUAC', 26, 1);
CALL insert_municipality('TIXPÉHUAL', 26, 1);
CALL insert_municipality('TIZIMÍN', 26, 1);
CALL insert_municipality('TUNKÁS', 26, 1);
CALL insert_municipality('TZUCACAB', 26, 1);
CALL insert_municipality('UAYMA', 26, 1);
CALL insert_municipality('UCÚ', 26, 1);
CALL insert_municipality('UMÁN', 26, 1);
CALL insert_municipality('VALLADOLID', 26, 1);
CALL insert_municipality('XOCCHEL', 26, 1);
CALL insert_municipality('YAXCABÁ', 26, 1);
CALL insert_municipality('YAXKUKUL', 26, 1);
CALL insert_municipality('YOBAÍN', 26, 1);

CALL insert_state('ZACATECAS', 1);
CALL insert_municipality('APOZOL', 27, 1);
CALL insert_municipality('APULCO', 27, 1);
CALL insert_municipality('ATOLINGA', 27, 1);
CALL insert_municipality('BENITO JUÁREZ', 27, 1);
CALL insert_municipality('CALERA', 27, 1);
CALL insert_municipality('CAÑITAS DE FELIPE PESCADOR', 27, 1);
CALL insert_municipality('CONCEPCIÓN DEL ORO', 27, 1);
CALL insert_municipality('CUAUHTÉMOC', 27, 1);
CALL insert_municipality('CHALCHIHUITES', 27, 1);
CALL insert_municipality('FRESNILLO', 27, 1);
CALL insert_municipality('TRINIDAD GARCÍA DE LA CADENA', 27, 1);
CALL insert_municipality('GENARO CODINA', 27, 1);
CALL insert_municipality('GENERAL ENRIQUE ESTRADA', 27, 1);
CALL insert_municipality('GENERAL FRANCISCO R. MURGUÍA', 27, 1);
CALL insert_municipality('EL PLATEADO DE JOAQUÍN AMARO', 27, 1);
CALL insert_municipality('GENERAL PÁNFILO NATERA', 27, 1);
CALL insert_municipality('GUADALUPE', 27, 1);
CALL insert_municipality('HUANUSCO', 27, 1);
CALL insert_municipality('JALPA', 27, 1);
CALL insert_municipality('JEREZ', 27, 1);
CALL insert_municipality('JIMÉNEZ DEL TEUL', 27, 1);
CALL insert_municipality('JUAN ALDAMA', 27, 1);
CALL insert_municipality('JUCHIPILA', 27, 1);
CALL insert_municipality('LORETO', 27, 1);
CALL insert_municipality('LUIS MOYA', 27, 1);
CALL insert_municipality('MAZAPIL', 27, 1);
CALL insert_municipality('MELCHOR OCAMPO', 27, 1);
CALL insert_municipality('MEZQUITAL DEL ORO', 27, 1);
CALL insert_municipality('MIGUEL AUZA', 27, 1);
CALL insert_municipality('MOMAX', 27, 1);
CALL insert_municipality('MONTE ESCOBEDO', 27, 1);
CALL insert_municipality('MORELOS', 27, 1);
CALL insert_municipality('MOYAHUA DE ESTRADA', 27, 1);
CALL insert_municipality('NOCHISTLÁN DE MEJÍA', 27, 1);
CALL insert_municipality('NORIA DE ÁNGELES', 27, 1);
CALL insert_municipality('OJOCALIENTE', 27, 1);
CALL insert_municipality('PÁNUCO', 27, 1);
CALL insert_municipality('PINOS', 27, 1);
CALL insert_municipality('RÍO GRANDE', 27, 1);
CALL insert_municipality('SAIN ALTO', 27, 1);
CALL insert_municipality('EL SALVADOR', 27, 1);
CALL insert_municipality('SOMBRERETE', 27, 1);
CALL insert_municipality('SUSTICACÁN', 27, 1);
CALL insert_municipality('TABASCO', 27, 1);
CALL insert_municipality('TEPECHITLÁN', 27, 1);
CALL insert_municipality('TEPETONGO', 27, 1);
CALL insert_municipality('TEÚL DE GONZÁLEZ ORTEGA', 27, 1);
CALL insert_municipality('TLALTENANGO DE SÁNCHEZ ROMÁN', 27, 1);
CALL insert_municipality('VALPARAÍSO', 27, 1);
CALL insert_municipality('VETAGRANDE', 27, 1);
CALL insert_municipality('VILLA DE COS', 27, 1);
CALL insert_municipality('VILLA GARCÍA', 27, 1);
CALL insert_municipality('VILLA GONZÁLEZ ORTEGA', 27, 1);
CALL insert_municipality('VILLA HIDALGO', 27, 1);
CALL insert_municipality('VILLANUEVA', 27, 1);
CALL insert_municipality('ZACATECAS', 27, 1);
CALL insert_municipality('TRANCOSO', 27, 1);
CALL insert_municipality('SANTA MARÍA DE LA PAZ', 27, 1);


-- ***************************************** --
-- ************** customer ***************** --
-- ***************************************** --

DELIMITER //
CREATE PROCEDURE insert_customer( IN var_full_name VARCHAR(255),
								  IN var_phone VARCHAR(255),
								  IN var_email VARCHAR(255),
								  IN var_housing VARCHAR(255),
								  IN var_street VARCHAR(255),
								  IN var_postal_code INT,
								  IN var_idMunicipality_Customer INT,
								  IN var_id_user INT )
BEGIN
	INSERT INTO customer(full_name, phone, email, housing, street, postal_code, idMunicipality_Customer)
		VALUES (var_full_name, var_phone, var_email, var_housing, var_street, var_postal_code, var_idMunicipality_Customer); 
    INSERT INTO log ( value, date, idTypeLog_Log, idTypeAction_Log, idUser_Log ) VALUES(JSON_OBJECT('customer_name', var_full_name), NOW(), 5, 1, var_id_user);
END
// DELIMITER ;

-- CALL insert_customer('[Some customer name]', '[Some customer phone]', '[Some customer email]', '[Some customer housing]', '[Some customer street]', [Some customer postal_code], [Some idMunicipality], [some idUser]);
CALL insert_customer('Ligia Villa Ferrándiz', '4771231212', 'ligia@gmail.com', 'SAN JOSE EL ALTO', 'BLVD AEROPUERTO', 37545, 823, 1);
CALL insert_customer('Sancho Ribera Benavente', '4770101011', 'sancho@gmail.com', 'LA MANCHA', 'PUENTECILLAS', 36250, 1500, 1);
CALL insert_customer('Bernardo Guerrero Hurtado', '4771041014', 'bernardo@gmail.com', 'CENTRO TUXTEPEC', 'CALLE MATAMOROS', 37104, 104, 1);
CALL insert_customer('Manu Mendez Grau', '4779239293', 'manu@gmail.com', 'CENTRO TUXTEPEC', 'INDEPENDENCIA', 37923, 923, 1);
CALL insert_customer('Anastasia Roura Fuertes', '4774004040', 'anastasia@gmail.com', 'CENTRO', 'AV. 5 DE MAYO', 37400, 400, 1);
CALL insert_customer('Julia Reyes Cortes', '4779219291', 'julia@gmail.com', 'TEMAZCAL.OAX', 'CALLE MATAMOROS', 37921, 1921, 1);
CALL insert_customer('Sol Menéndez Tovar', '4779299299', 'sol@gmail.com', 'JOSE LOPEZ PORTILLO II', 'CALLE BORNEO', 37929, 1929, 1);
CALL insert_customer('Diana Castillo Medina', '4772872827', 'diana@gmail.com', 'TLAXCOPAN', 'CALLE ISLA LUZÓN', 37287, 2287, 1);
CALL insert_customer('Brunilda Artigas Arce', '4777697679', 'brunilda@gmail.com', 'LA COLMENA', 'QUINTA DEL PARQUE', 37769, 769, 1);
CALL insert_customer('Eleuterio Rocha Isern', '4771801810', 'eleuterio@gmail.com', 'GENERAL FELIPE BERRIOZABAL', 'QUITO', 37180, 180, 1);
CALL insert_customer('Amalia Reina Marin', '4771251215', 'amalia@gmail.com', 'PROVIDENCIA', 'XOCHIMILCO', 37125, 125, 1);
CALL insert_customer('Amor Alemán Zaragoza', '4775285258', 'amor@gmail.com', 'PUEBLO NUEVO', 'TORRE CERREDO', 37528, 1528, 1);
CALL insert_customer('Benito Ugarte Bolaños', '4776926962', 'benito@gmail.com', 'LA RAZA', 'TRES', 37892, 1692, 1);
CALL insert_customer('Adoración Vall Narváez', '4777387378', 'adoracion@gmail.com', 'TLACATEL', 'VICARIO', 37738, 1738, 1);
CALL insert_customer('Coral Cazorla Mulet', '4772292229', 'coral@gmail.com', 'EL BATAN', 'VALENCIA', 37229, 1229, 1);
CALL insert_customer('Seve Lucio Nogueira Pombo', '4772792729', 'seve@gmail.com', 'CALZUCO', 'WAGNER', 37279, 1279, 1);
CALL insert_customer('Jeremías Mateos Solís', '4770570507', 'jeremias@gmail.com', 'DOLORES LI', 'KIRUMA', 37057, 1057, 1);
CALL insert_customer('Chus Pedro Sosa', '4770490409', 'chus@gmail.com', 'EL MOLINILLO', 'KAPPA', 37049, 2049, 1);
CALL insert_customer('Basilio Infante-Rius', '4773343334', 'basilio@gmail.com', 'GABRIEL HERNANDEZ', 'NABO', 37334, 334, 1);
CALL insert_customer('Albano Vázquez Fajardo', '4777227272', 'albano@gmail.com', 'PÓLVORA', 'NEPTUNO', 37722, 722, 1);



DELIMITER //
CREATE PROCEDURE delete_customer( IN var_idCustomer INT,
								  IN var_id_user INT )
BEGIN
	UPDATE customer SET
		status = FALSE
	WHERE idCustomer = var_idCustomer;
    SET @customername = (SELECT full_name FROM customer WHERE idCustomer = var_idCustomer);
    INSERT INTO log ( value, date, idTypeLog_Log, idTypeAction_Log, idUser_Log ) VALUES(JSON_OBJECT('customer_name', @customername ), NOW(), 5, 3, var_id_user);
END
// DELIMITER ;

-- CALL delete_customer([Some idCustomer], [Some idUser]);
CALL delete_customer(1, 1);

DELIMITER //
CREATE PROCEDURE update_customer( IN var_idCustomer INT,
							      IN var_full_name VARCHAR(255),
								  IN var_phone VARCHAR(255),
								  IN var_email VARCHAR(255),
								  IN var_housing VARCHAR(255),
								  IN var_street VARCHAR(255),
								  IN var_postal_code INT,
								  IN var_idMunicipality_Customer INT,
								  IN var_id_user INT )
BEGIN
	SET @var_json_final = '[';
    
    IF var_full_name != ( SELECT full_name FROM customer WHERE idCustomer = var_idCustomer ) THEN 
	   SET @var_json_final = CONCAT(@var_json_final, JSON_OBJECT('full_name_customer', true));
	END IF;
    
    IF var_phone != ( SELECT phone FROM customer WHERE idCustomer = var_idCustomer ) THEN 
	   SET @var_json_final = CONCAT(@var_json_final, JSON_OBJECT('phone_customer', true));
	END IF;
    
    IF var_email != ( SELECT email FROM customer WHERE idCustomer = var_idCustomer ) THEN 
	   SET @var_json_final = CONCAT(@var_json_final, JSON_OBJECT('email_customer', true));
	END IF;
    
    IF var_housing != ( SELECT housing FROM customer WHERE idCustomer = var_idCustomer ) THEN 
	   SET @var_json_final = CONCAT(@var_json_final, JSON_OBJECT('housing_customer', true));
	END IF;
    
    IF var_street != ( SELECT street FROM customer WHERE idCustomer = var_idCustomer ) THEN 
	   SET @var_json_final = CONCAT(@var_json_final, JSON_OBJECT('street_customer', true));
	END IF;
    
    IF var_postal_code != ( SELECT postal_code FROM customer WHERE idCustomer = var_idCustomer ) THEN 
	   SET @var_json_final = CONCAT(@var_json_final, JSON_OBJECT('postal_code_customer', true));
	END IF;

    IF var_idMunicipality_Customer != ( SELECT idMunicipality_Customer FROM customer WHERE idCustomer = var_idCustomer ) THEN 
	   SET @var_json_final = CONCAT(@var_json_final, JSON_OBJECT('idMunicipality_Customer_customer', true));
	END IF;

    SET @var_json_final = CONCAT(@var_json_final, ']');
	UPDATE customer 
SET 
    full_name = var_full_name,
    phone = var_phone,
    email = var_email,
    housing = var_housing,
    street = var_street,
    postal_code = var_postal_code,
    idMunicipality_Customer = var_idMunicipality_Customer
WHERE
    idCustomer = var_idCustomer;
    INSERT INTO log ( value, date, idTypeLog_Log, idTypeAction_Log, idUser_Log ) VALUES(@var_json_final, NOW(), 5, 2, var_id_user);
END
// DELIMITER ;

-- CALL update_customer([Some idCustomer], '[Some customer full_name]', '[Some customer phone]', '[Some customer email]', '[Some customer housing]', '[Some customer street]', [Some customer postal_code], [Some customer idMunicipality], [Some idUser]);
CALL update_customer(1, 'Ferrándiz', '4770000000', 'fer@gmail.com', 'JOSE EL ALTO', 'AEROPUERTO', 37000, 800, 1);


