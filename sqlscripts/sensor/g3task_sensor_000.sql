BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS `deviceinfo` (
	`iddeviceinfo`	INTEGER NOT NULL,
	`iddevice`	INTEGER NOT NULL,
	`datastructure`	text NOT NULL,
	`lastupdated`	datetime NOT NULL,
	`createdon`	datetime NOT NULL DEFAULT current_timestamp,
	CONSTRAINT `sqlite_master_PK_deviceinfo` PRIMARY KEY(`iddeviceinfo`),
	FOREIGN KEY(`iddevice`) REFERENCES `device`(`iddevice`)
);
CREATE TABLE IF NOT EXISTS `devicedata` (
	`iddevicedata`	INTEGER NOT NULL,
	`iddevice`	INTEGER NOT NULL,
	`rawdata`	text NOT NULL,
	`createdon`	datetime NOT NULL DEFAULT current_timestamp,
	`validated`	bigint NOT NULL DEFAULT 0,
	CONSTRAINT `sqlite_master_PK_devicedate` PRIMARY KEY(`iddevicedata`),
	FOREIGN KEY(`iddevice`) REFERENCES `device`(`iddevice`)
);
CREATE TABLE IF NOT EXISTS `device` (
	`iddevice`	INTEGER NOT NULL,
	`idproject`	INTEGER NOT NULL,
	`name`	text NOT NULL,
	`partnro`	text NOT NULL,
	`token`	text NOT NULL,
	`secretcode`	text NOT NULL,
	`lastupdated`	datetime NOT NULL DEFAULT current_timestamp,
	`createdon`	datetime NOT NULL DEFAULT current_timestamp,
	`inactive`	bigint NOT NULL DEFAULT 0,
	`deleted`	bigint NOT NULL DEFAULT 0,
	`ip`	text NOT NULL DEFAULT '',
	`url`	text NOT NULL DEFAULT '',
	`gps`	text NOT NULL DEFAULT '',
	`country`	text NOT NULL DEFAULT '',
	`city`	text NOT NULL DEFAULT '',
	`state`	text NOT NULL DEFAULT '',
	`address1`	text NOT NULL DEFAULT '',
	`address2`	text NOT NULL DEFAULT '',
	`address3`	text NOT NULL DEFAULT '',
	`phone`	text NOT NULL DEFAULT '',
	`zipcode`	text NOT NULL DEFAULT '',
	`email`	text NOT NULL DEFAULT '',
	`weburl`	text NOT NULL DEFAULT '',
	`contact`	text NOT NULL DEFAULT '',
	CONSTRAINT `sqlite_master_PK_device` PRIMARY KEY(`iddevice`)
);
CREATE TRIGGER device BEFORE UPDATE ON device BEGIN UPDATE device SET lastupdated = current_timestamp WHERE iddevice = new.iddevice; END;
COMMIT;
