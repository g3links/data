BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS `version` (
	`ver`	text NOT NULL DEFAULT '1.0.0'
);
CREATE TABLE IF NOT EXISTS `userprovider` (
	`iduser`	INTEGER NOT NULL,
	`idprovider`	text NOT NULL,
	`token`	text NOT NULL,
	`createdon`	datetime NOT NULL DEFAULT current_timestamp,
	`lastupdatedon`	datetime NOT NULL DEFAULT current_timestamp,
	FOREIGN KEY(`iduser`) REFERENCES `user`(`iduser`),
	CONSTRAINT `sqlite_master_PK_userprovider` PRIMARY KEY(`iduser`,`idprovider`)
);
CREATE TABLE IF NOT EXISTS `user_h` (
	`iduserh`	INTEGER NOT NULL,
	`iduser`	INTEGER NOT NULL,
	`name`	text,
	`email`	text,
	`keyname`	text,
	`idproject`	INTEGER,
	`lastmodifiedon`	datetime NOT NULL,
	`createdon`	datetime NOT NULL DEFAULT current_timestamp,
	CONSTRAINT `sqlite_master_PK_user_h` PRIMARY KEY(`iduserh`),
	FOREIGN KEY(`iduser`) REFERENCES `user`(`iduser`)
);
CREATE TABLE IF NOT EXISTS `user` (
	`iduser`	INTEGER NOT NULL,
	`name`	text NOT NULL,
	`email`	text NOT NULL,
	`createdon`	datetime NOT NULL DEFAULT current_timestamp,
	`lastaccesson`	datetime NOT NULL DEFAULT current_timestamp,
	`isvalidated`	bigint NOT NULL DEFAULT 0,
	`deleted`	bigint NOT NULL DEFAULT 0,
	`securekey`	INTEGER NOT NULL DEFAULT 0,
	`keyname`	text NOT NULL DEFAULT '',
	`idproject`	INTEGER NOT NULL DEFAULT 0,
	`theme`	text NOT NULL DEFAULT '',
	CONSTRAINT `sqlite_master_PK_user` PRIMARY KEY(`iduser`)
);
CREATE TABLE IF NOT EXISTS `projectuser` (
	`idproject`	INTEGER NOT NULL,
	`iduser`	INTEGER NOT NULL,
	`idrole`	INTEGER NOT NULL,
	`inactive`	bigint NOT NULL DEFAULT 0,
	`idaccess`	INTEGER NOT NULL DEFAULT 1,
	`createdon`	datetime NOT NULL DEFAULT current_timestamp,
	`lastmodifiedon`	datetime NOT NULL DEFAULT current_timestamp,
	FOREIGN KEY(`idproject`) REFERENCES `project`(`idproject`),
	FOREIGN KEY(`iduser`) REFERENCES `user`(`iduser`)
);
CREATE TABLE IF NOT EXISTS `projectservice` (
	`idproject`	INTEGER NOT NULL,
	`name`	INTEGER NOT NULL,
	`template`	text NOT NULL DEFAULT '',
	`createdon`	datetime NOT NULL DEFAULT current_timestamp,
	`lastmodifiedon`	datetime NOT NULL DEFAULT current_timestamp,
	CONSTRAINT `sqlite_master_PK_projectservice` PRIMARY KEY(`idproject`,`name`),
	FOREIGN KEY(`idproject`) REFERENCES `project`(`idproject`)
);
CREATE TABLE IF NOT EXISTS `projectinvitation` (
	`idprojectinv`	INTEGER NOT NULL,
	`idproject`	INTEGER NOT NULL,
	`iduser`	INTEGER NOT NULL,
	`iduserinvited`	INTEGER NOT NULL,
	`usernameinvited`	text NOT NULL,
	`useremailinvited`	text NOT NULL,
	`idrole`	INTEGER NOT NULL,
	`createdon`	datetime NOT NULL DEFAULT current_timestamp,
	`securekey`	INTEGER NOT NULL DEFAULT 0,
	FOREIGN KEY(`idproject`) REFERENCES `project`(`idproject`),
	FOREIGN KEY(`idrole`) REFERENCES `role`(`idrole`),
	FOREIGN KEY(`iduser`) REFERENCES `user`(`iduser`),
	CONSTRAINT `sqlite_master_PK_projectinvitation` PRIMARY KEY(`idprojectinv`)
);
CREATE TABLE IF NOT EXISTS `project_h` (
	`idprojecth`	INTEGER NOT NULL,
	`idproject`	INTEGER NOT NULL,
	`description`	text,
	`startupwidth`	INTEGER,
	`startuppath`	text,
	`ispublic`	bigint,
	`marketname`	text,
	`title`	text,
	`prefix`	text,
	`ticketseq`	INTEGER,
	`remoteurl`	text,
	`idcurrency`	text,
	`lastmodifiedon`	datetime NOT NULL,
	`createdon`	datetime NOT NULL DEFAULT current_timestamp,
	CONSTRAINT `sqlite_master_PK_project_h` PRIMARY KEY(`idprojecth`),
	FOREIGN KEY(`idproject`) REFERENCES `project`(`idproject`)
);
CREATE TABLE IF NOT EXISTS `project` (
	`idproject`	INTEGER NOT NULL,
	`description`	text NOT NULL,
	`deleted`	bigint NOT NULL DEFAULT 0,
	`createdon`	datetime NOT NULL DEFAULT current_timestamp,
	`lastmodifiedon`	datetime NOT NULL DEFAULT current_timestamp,
	`startuppath`	text NOT NULL,
	`startupwidth`	INTEGER NOT NULL DEFAULT 400,
	`ispublic`	bigint NOT NULL DEFAULT 0,
	`marketname`	text NOT NULL DEFAULT '',
	`title`	text NOT NULL DEFAULT '',
	`prefix`	text NOT NULL DEFAULT '',
	`ticketseq`	INTEGER NOT NULL DEFAULT 0,
	`remoteurl`	text NOT NULL DEFAULT '',
	`idcurrency`	text NOT NULL DEFAULT 'USD',
	CONSTRAINT `sqlite_master_PK_project` PRIMARY KEY(`idproject`)
);
CREATE TABLE IF NOT EXISTS `needauth` (
	`iduser`	INTEGER NOT NULL,
	`provider`	text NOT NULL,
	`createdon`	datetime DEFAULT current_timestamp,
	`isauth`	bigint NOT NULL DEFAULT 0,
	`issend`	bigint NOT NULL DEFAULT 0
);
CREATE UNIQUE INDEX IF NOT EXISTS `project_user` ON `projectuser` (
	`idproject`,
	`iduser`
);
CREATE TRIGGER userprovider BEFORE UPDATE ON userprovider BEGIN UPDATE userprovider SET lastupdatedon = current_timestamp WHERE iduser = new.iduser;  END;
CREATE TRIGGER user BEFORE UPDATE ON user BEGIN INSERT INTO user_h (iduser,name,emal,keyname,idproject,lastmodifiedon) VALUES(OLD.iduser,OLD.name,emal,OLD.keyname,OLD.idproject,OLD.lastaccesson); UPDATE user SET lastaccesson = current_timestamp WHERE iduser = new.iduser;  END;
CREATE TRIGGER projectuser BEFORE UPDATE ON projectuser BEGIN UPDATE projectuser SET lastmodifiedon = current_timestamp WHERE idproject = NEW.idproject AND iduser = NEW.iduser;  END;
CREATE TRIGGER projectservice BEFORE UPDATE ON projectservice BEGIN UPDATE projectservice SET lastmodifiedon = current_timestamp WHERE idproject = NEW.idproject AND name = NEW.name;  END;
CREATE TRIGGER project BEFORE UPDATE ON project BEGIN INSERT INTO project_h (idproject,description,startupwidth,startuppath,ispublic,marketname,title,prefix,ticketseq,remoteurl,idcurrency,lastmodifiedon) VALUES(OLD.idproject,OLD.description,OLD.startupwidth,OLD.startuppath,OLD.ispublic,OLD.marketname,OLD.title,OLD.prefix,OLD.ticketseq,OLD.remoteurl,OLD.idcurrency,OLD.lastmodifiedon); UPDATE project SET lastmodifiedon = current_timestamp WHERE idproject = new.idproject;  END;
COMMIT;
