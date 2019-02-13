BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS `version` (
	`ver`	text NOT NULL DEFAULT '1.0.0'
);
CREATE TABLE IF NOT EXISTS `taskuser` (
	`idtaskuser`	INTEGER NOT NULL,
	`idtask`	INTEGER NOT NULL,
	`iduser`	INTEGER NOT NULL,
	`taskusername`	text NOT NULL DEFAULT '',
	`createdon`	datetime NOT NULL DEFAULT current_timestamp,
	CONSTRAINT `sqlite_master_PK_taskuser` PRIMARY KEY(`idtaskuser`),
	FOREIGN KEY(`idtask`) REFERENCES `task`(`idtask`)
);
CREATE TABLE IF NOT EXISTS `tasktag` (
	`idtag`	INTEGER NOT NULL,
	`idtask`	INTEGER NOT NULL,
	`iduser`	INTEGER NOT NULL,
	`tagname`	text NOT NULL DEFAULT '',
	`tagcolor`	text NOT NULL DEFAULT '',
	`createon`	datetime NOT NULL DEFAULT current_timestamp,
	FOREIGN KEY(`idtask`) REFERENCES `task`(`idtask`),
	CONSTRAINT `sqlite_master_PK_tasktag` PRIMARY KEY(`idtag`)
);
CREATE TABLE IF NOT EXISTS `taskowner` (
	`idtaskowner`	INTEGER NOT NULL,
	`idtask`	INTEGER NOT NULL,
	`iduser`	INTEGER NOT NULL,
	`username`	text NOT NULL DEFAULT '',
	`createdon`	datetime NOT NULL DEFAULT current_timestamp,
	CONSTRAINT `sqlite_master_PK_taskowner` PRIMARY KEY(`idtaskowner`),
	FOREIGN KEY(`idtask`) REFERENCES `task`(`idtask`)
);
CREATE TABLE IF NOT EXISTS `taskhold` (
	`idtaskhold`	INTEGER NOT NULL,
	`idtask`	INTEGER NOT NULL,
	`description`	TEXT NOT NULL,
	`createon`	datetime NOT NULL DEFAULT current_timestamp,
	`lastmodifiedon`	datetime NOT NULL DEFAULT current_timestamp,
	FOREIGN KEY(`idtask`) REFERENCES `task`(`idtask`),
	CONSTRAINT `sqlite_master_PK_taskhold` PRIMARY KEY(`idtaskhold`)
);
CREATE TABLE IF NOT EXISTS `taskgroup` (
	`idtaskgroup`	INTEGER NOT NULL,
	`idtask`	INTEGER NOT NULL,
	`idgroup`	INTEGER NOT NULL,
	`taskgroupname`	text NOT NULL DEFAULT '',
	`createdon`	datetime NOT NULL DEFAULT current_timestamp,
	FOREIGN KEY(`idgroup`) REFERENCES `projgroup`(`idgroup`),
	CONSTRAINT `sqlite_master_PK_taskgroup` PRIMARY KEY(`idtaskgroup`),
	FOREIGN KEY(`idtask`) REFERENCES `task`(`idtask`)
);
CREATE TABLE IF NOT EXISTS `taskdue` (
	`idtaskdue`	INTEGER NOT NULL,
	`idtask`	INTEGER NOT NULL,
	`starton`	datetime,
	`dueon`	datetime,
	`duration`	INTEGER NOT NULL DEFAULT 0,
	`createon`	datetime NOT NULL DEFAULT current_timestamp,
	`lastmodifiedon`	datetime NOT NULL DEFAULT current_timestamp,
	CONSTRAINT `sqlite_master_PK_taskdue` PRIMARY KEY(`idtaskdue`),
	FOREIGN KEY(`idtask`) REFERENCES `task`(`idtask`)
);
CREATE TABLE IF NOT EXISTS `task_h` (
	`idtaskh`	INTEGER NOT NULL,
	`idtask`	INTEGER NOT NULL,
	`title`	text,
	`description`	text,
	`idpriority`	INTEGER,
	`idparent`	INTEGER,
	`progress`	INTEGER,
	`idgate`	INTEGER,
	`idtrack`	INTEGER,
	`idcategory`	INTEGER,
	`lastmodifiedon`	datetime NOT NULL,
	`createdon`	datetime NOT NULL DEFAULT current_timestamp,
	`module`	text,
	`idmodule`	INTEGER,
	CONSTRAINT `sqlite_master_PK_taskh` PRIMARY KEY(`idtaskh`)
);
CREATE TABLE IF NOT EXISTS `task` (
	`idtask`	INTEGER NOT NULL,
	`idpriority`	INTEGER NOT NULL DEFAULT 1,
	`createdon`	datetime NOT NULL DEFAULT current_timestamp,
	`lastmodifiedon`	datetime NOT NULL DEFAULT current_timestamp,
	`title`	text NOT NULL,
	`description`	text DEFAULT '',
	`idparent`	INTEGER NOT NULL DEFAULT 0,
	`hasattach`	bigint NOT NULL DEFAULT 0,
	`progress`	INTEGER NOT NULL DEFAULT 0,
	`idgate`	INTEGER NOT NULL DEFAULT 0,
	`idtrack`	INTEGER NOT NULL DEFAULT 0,
	`idcategory`	INTEGER NOT NULL DEFAULT 0,
	`module`	text NOT NULL DEFAULT '',
	`idmodule`	INTEGER NOT NULL DEFAULT 0,
	CONSTRAINT `sqlite_master_PK_task` PRIMARY KEY(`idtask`)
);
CREATE TABLE IF NOT EXISTS `sharedataproj` (
	`idsharedataproj`	INTEGER NOT NULL,
	`setname`	text NOT NULL,
	`idproject`	INTEGER NOT NULL,
	`createon`	datetime NOT NULL DEFAULT current_timestamp,
	`deleted`	bigint NOT NULL DEFAULT 0,
	`inactiveon`	datetime NOT NULL DEFAULT current_timestamp,
	`requirerefresh`	bigint NOT NULL DEFAULT 0,
	CONSTRAINT `sqlite_master_PK_sharedataproj` PRIMARY KEY(`idsharedataproj`),
	FOREIGN KEY(`setname`) REFERENCES `sharedata`(`setname`)
);
CREATE TABLE IF NOT EXISTS `sharedata` (
	`setname`	text NOT NULL,
	`createon`	datetime NOT NULL DEFAULT current_timestamp,
	CONSTRAINT `sqlite_master_PK_sharedata` PRIMARY KEY(`setname`)
);
CREATE TABLE IF NOT EXISTS `secrole` (
	`idsecrole`	INTEGER NOT NULL,
	`iduser`	INTEGER NOT NULL,
	`seccode`	text NOT NULL,
	`idrole`	INTEGER NOT NULL,
	CONSTRAINT `sqlite_master_PK_secrole` PRIMARY KEY(`idsecrole`)
);
CREATE TABLE IF NOT EXISTS `projgroupuser` (
	`idgroupuser`	INTEGER NOT NULL,
	`idgroup`	INTEGER NOT NULL,
	`iduser`	INTEGER NOT NULL,
	`createdon`	datetime NOT NULL DEFAULT current_timestamp,
	`deleted`	bigint NOT NULL DEFAULT 0,
	CONSTRAINT `sqlite_master_PK_projgroupuser` PRIMARY KEY(`idgroupuser`),
	FOREIGN KEY(`idgroup`) REFERENCES `projgroup`(`idgroup`)
);
CREATE TABLE IF NOT EXISTS `projgroup` (
	`idgroup`	INTEGER NOT NULL,
	`groupname`	text NOT NULL,
	`createdon`	datetime NOT NULL DEFAULT current_timestamp,
	`deleted`	bigint NOT NULL DEFAULT 0,
	CONSTRAINT `sqlite_master_PK_projgroup` PRIMARY KEY(`idgroup`)
);
CREATE TABLE IF NOT EXISTS `projectowner` (
	`iduser`	INTEGER NOT NULL,
	`createdon`	datetime NOT NULL DEFAULT current_timestamp,
	CONSTRAINT `sqlite_master_PK_projectowner` PRIMARY KEY(`iduser`)
);
CREATE TABLE IF NOT EXISTS `notedetail` (
	`idnotedetail`	INTEGER NOT NULL,
	`idnote`	INTEGER NOT NULL,
	`iduser`	INTEGER NOT NULL,
	`sendername`	text NOT NULL,
	`notetext`	text NOT NULL,
	`createdon`	datetime NOT NULL DEFAULT current_timestamp,
	`package`	text NOT NULL DEFAULT '',
	`url`	text NOT NULL DEFAULT '',
	CONSTRAINT `sqlite_master_PK_notedetail` PRIMARY KEY(`idnotedetail`),
	FOREIGN KEY(`idnote`) REFERENCES `note`(`idnote`)
);
CREATE TABLE IF NOT EXISTS `notebroadcast` (
	`idnoteuser`	INTEGER NOT NULL,
	`idnote`	INTEGER NOT NULL,
	`iduser`	INTEGER NOT NULL,
	`membername`	text NOT NULL,
	`deleted`	bigint NOT NULL DEFAULT 0,
	`isnew`	bigint NOT NULL DEFAULT 1,
	`inactiveon`	datetime NOT NULL DEFAULT current_timestamp,
	CONSTRAINT `sqlite_master_PK_notebroadcast` PRIMARY KEY(`idnoteuser`),
	FOREIGN KEY(`idnote`) REFERENCES `note`(`idnote`)
);
CREATE TABLE IF NOT EXISTS `note` (
	`idnote`	INTEGER NOT NULL,
	CONSTRAINT `sqlite_master_PK_note` PRIMARY KEY(`idnote`)
);
CREATE TABLE IF NOT EXISTS `filterview` (
	`iduser`	INTEGER NOT NULL,
	`idview`	INTEGER NOT NULL,
	CONSTRAINT `sqlite_master_PK_filterview` PRIMARY KEY(`iduser`,`idview`)
);
CREATE TABLE IF NOT EXISTS `comment` (
	`idcomment`	INTEGER NOT NULL,
	`idtask`	INTEGER NOT NULL,
	`description`	text NOT NULL DEFAULT '',
	`source`	text NOT NULL DEFAULT '',
	`createdon`	datetime NOT NULL DEFAULT current_timestamp,
	`lastmodifiedon`	datetime NOT NULL DEFAULT current_timestamp,
	`deleted`	bigint NOT NULL DEFAULT 0,
	`iduser`	INTEGER NOT NULL,
	`username`	text NOT NULL DEFAULT '',
	CONSTRAINT `sqlite_master_PK_comment` PRIMARY KEY(`idcomment`),
	FOREIGN KEY(`idtask`) REFERENCES `task`(`idtask`)
);
CREATE TRIGGER taskhold BEFORE UPDATE ON taskhold BEGIN UPDATE taskhold SET lastmodifiedon = current_timestamp WHERE idtaskhold = new.idttaskhold; END;
CREATE TRIGGER taskdue BEFORE UPDATE ON taskdue BEGIN UPDATE taskdue SET lastmodifiedon = current_timestamp WHERE idtaskdue = new.idtaskdue; END;
CREATE TRIGGER task_d BEFORE DELETE ON task BEGIN INSERT INTO task_h (idtask,title,description,idpriority,idparent,progress,idgate,idtrack,idcategory,module,idmodule,lastmodifiedon) VALUES(OLD.idtask,OLD.title,OLD.description,OLD.idpriority,OLD.idparent,OLD.progress,OLD.idgate,OLD.idtrack,OLD.idcategory,OLD.module,OLD.idmodule, OLD.createdon);END;
CREATE TRIGGER task BEFORE UPDATE ON task BEGIN INSERT INTO task_h (idtask,title,description,idpriority,idparent,progress,idgate,idtrack,idcategory,module,idmodule,lastmodifiedon) VALUES(OLD.idtask,OLD.title,OLD.description,OLD.idpriority,OLD.idparent,OLD.progress,OLD.idgate,OLD.idtrack,OLD.idcategory,OLD.module,OLD.idmodule,OLD.lastmodifiedon); UPDATE task SET lastmodifiedon = current_timestamp WHERE idtask = new.idtask; END;
CREATE TRIGGER comment BEFORE UPDATE ON comment BEGIN UPDATE comment SET lastmodifiedon = current_timestamp WHERE idcomment = new.idcomment; END;
COMMIT;
