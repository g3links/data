BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS `productpaytype` (
	`idproductpaytype`	INTEGER NOT NULL,
	`idproduct`	INTEGER NOT NULL,
	`idpaytype`	INTEGER NOT NULL,
	`createon`	datetime NOT NULL DEFAULT current_timestamp,
	`lastmodifiedon`	datetime NOT NULL DEFAULT current_timestamp,
	CONSTRAINT `sqlite_master_PK_salespaytype` PRIMARY KEY(`idproductpaytype`),
	FOREIGN KEY(`idpaytype`) REFERENCES `paytype`(`idpaytype`),
	FOREIGN KEY(`idproduct`) REFERENCES `product`(`idproduct`)
);
CREATE TABLE IF NOT EXISTS `taskorder` (
	`idorder`	INTEGER NOT NULL,
	`idtask`	INTEGER NOT NULL,
	FOREIGN KEY(`idorder`) REFERENCES `order`(`idorder`),
	CONSTRAINT `sqlite_master_PK_taskorder` PRIMARY KEY(`idorder`,`idtask`),
	FOREIGN KEY(`idtask`) REFERENCES `task`(`idtask`)
);
CREATE UNIQUE INDEX IF NOT EXISTS `product_paytype` ON `productpaytype` (
	`idproduct`,
	`idpaytype`
);
CREATE TABLE IF NOT EXISTS `producttag` (
	`idtag`	text NOT NULL,
	`idproduct`	INTEGER NOT NULL,
	CONSTRAINT `sqlite_master_PK_producttag` PRIMARY KEY(`idtag`,`idproduct`)
);
CREATE TABLE IF NOT EXISTS `productdetail_h` (
	`idproducth`	INTEGER NOT NULL,
	`idproduct`	INTEGER NOT NULL,
	`productdescription`	text,
	`productmanifest`	text,
	`idcurrency`	text,
	`saleprice`	NUMERIC,
	`iduser`	text NOT NULL,
	`username`	text NOT NULL,
	`lastmodifiedon`	datetime NOT NULL DEFAULT current_timestamp,
	`createon`	datetime NOT NULL DEFAULT current_timestamp,
	CONSTRAINT `sqlite_master_PK_productdetailh` PRIMARY KEY(`idproducth`)
);
CREATE TABLE IF NOT EXISTS `productdetail` (
	`idproduct`	INTEGER NOT NULL,
	`productdescription`	text NOT NULL,
	`productmanifest`	text NOT NULL,
	`idcurrency`	text NOT NULL,
	`saleprice`	NUMERIC NOT NULL DEFAULT 0,
	`iduser`	text NOT NULL,
	`username`	text NOT NULL,
	`createon`	datetime NOT NULL DEFAULT current_timestamp,
	`lastmodifiedon`	datetime NOT NULL DEFAULT current_timestamp,
	CONSTRAINT `sqlite_master_PK_productdetail` PRIMARY KEY(`idproduct`),
	FOREIGN KEY(`idproduct`) REFERENCES `product`(`idproduct`)
);
CREATE TABLE IF NOT EXISTS `product_h` (
	`idproducth`	INTEGER NOT NULL,
	`idproduct`	INTEGER NOT NULL,
	`keycode`	text,
	`name`	text,
	`inactive`	bigint,
	`deleted`	bigint,
	`idproject`	INTEGER,
	`srcidproduct`	INTEGER,
	`issales`	bigint,
	`ispurchase`	bigint,
	`tags`	text,
	`iduser`	text NOT NULL,
	`username`	text NOT NULL,
	`createon`	datetime NOT NULL DEFAULT current_timestamp,
	`lastmodifiedon`	datetime NOT NULL DEFAULT current_timestamp,
	CONSTRAINT `sqlite_master_PK_producth` PRIMARY KEY(`idproducth`)
);
CREATE TABLE IF NOT EXISTS `product` (
	`idproduct`	INTEGER NOT NULL,
	`keycode`	text,
	`name`	text NOT NULL,
	`inactive`	bigint NOT NULL DEFAULT 0,
	`deleted`	bigint NOT NULL DEFAULT 0,
	`createon`	datetime NOT NULL DEFAULT current_timestamp,
	`lastmodifiedon`	datetime NOT NULL DEFAULT current_timestamp,
	`idproject`	INTEGER NOT NULL DEFAULT 0,
	`srcidproduct`	INTEGER NOT NULL DEFAULT 0,
	`issales`	bigint NOT NULL DEFAULT 1,
	`ispurchase`	bigint NOT NULL DEFAULT 1,
	`tags`	text,
	`iduser`	text NOT NULL,
	`username`	text NOT NULL,
	CONSTRAINT `sqlite_master_PK_product` PRIMARY KEY(`idproduct`)
);
CREATE TABLE IF NOT EXISTS `orderfulfill_h` (
	`idorderfulfillh`	INTEGER NOT NULL,
	`idorderfulfill`	INTEGER NOT NULL,
	`idorderdetail`	INTEGER NOT NULL,
	`qtyfulfill`	INTEGER,
	`iduser`	INTEGER,
	`username`	text,
	`createdon`	datetime NOT NULL DEFAULT current_timestamp,
	`lastmodifiedon`	datetime NOT NULL,
	CONSTRAINT `sqlite_master_PK_orderfulfillh` PRIMARY KEY(`idorderfulfillh`)
);
CREATE TABLE IF NOT EXISTS `orderfulfill` (
	`idorderfulfill`	INTEGER NOT NULL,
	`idorderdetail`	INTEGER NOT NULL,
	`qtyfulfill`	INTEGER NOT NULL DEFAULT 0,
	`createdon`	datetime NOT NULL DEFAULT current_timestamp,
	`lastmodifiedon`	datetime NOT NULL DEFAULT current_timestamp,
	`iduser`	INTEGER NOT NULL,
	`username`	text NOT NULL,
	CONSTRAINT `sqlite_master_PK_orderfulfill` PRIMARY KEY(`idorderfulfill`),
	FOREIGN KEY(`idorderdetail`) REFERENCES `orderdetail`(`idorderdetail`)
);
CREATE TABLE IF NOT EXISTS `orderdetail_h` (
	`idorderdetailh`	INTEGER NOT NULL,
	`idorderdetail`	INTEGER NOT NULL,
	`idorder`	INTEGER NOT NULL,
	`idproduct`	INTEGER NOT NULL,
	`srcidproduct`	INTEGER NOT NULL DEFAULT 0,
	`idproject`	INTEGER NOT NULL DEFAULT 0,
	`productcode`	text NOT NULL,
	`productname`	text NOT NULL,
	`orderquantity`	INTEGER NOT NULL DEFAULT 0,
	`productdescription`	text NOT NULL,
	`productmanifest`	text NOT NULL,
	`idcurrencyfrom`	text NOT NULL,
	`idcurrencyto`	text NOT NULL,
	`rateconv`	NUMERIC NOT NULL DEFAULT 0,
	`saleprice`	NUMERIC NOT NULL DEFAULT 0,
	`createdon`	datetime NOT NULL DEFAULT current_timestamp,
	`lastmodifiedon`	datetime NOT NULL,
	CONSTRAINT `sqlite_master_PK_orderdetailh` PRIMARY KEY(`idorderdetailh`)
);
CREATE TABLE IF NOT EXISTS `orderdetail` (
	`idorderdetail`	INTEGER NOT NULL,
	`idorder`	INTEGER NOT NULL,
	`idproduct`	INTEGER NOT NULL,
	`srcidproduct`	INTEGER NOT NULL DEFAULT 0,
	`idproject`	INTEGER NOT NULL DEFAULT 0,
	`productcode`	text NOT NULL,
	`productname`	text NOT NULL,
	`orderquantity`	INTEGER NOT NULL DEFAULT 0,
	`productdescription`	text NOT NULL,
	`productmanifest`	text NOT NULL,
	`idcurrencyfrom`	text NOT NULL,
	`idcurrencyto`	text NOT NULL,
	`rateconv`	NUMERIC NOT NULL DEFAULT 0,
	`saleprice`	NUMERIC NOT NULL DEFAULT 0,
	`createdon`	datetime NOT NULL DEFAULT current_timestamp,
	`lastmodifiedon`	datetime NOT NULL DEFAULT current_timestamp,
	CONSTRAINT `sqlite_master_PK_orderdetail` PRIMARY KEY(`idorderdetail`),
	FOREIGN KEY(`idproduct`) REFERENCES `product`(`idproduct`),
	FOREIGN KEY(`idorder`) REFERENCES `order`(`idorder`)
);
CREATE TABLE IF NOT EXISTS `order_h` (
	`idorderh`	INTEGER NOT NULL,
	`idorder`	INTEGER,
	`idpriority`	INTEGER,
	`progress`	INTEGER,
	`idgate`	INTEGER,
	`idtrack`	INTEGER,
	`idcategory`	INTEGER,
	`description`	text NOT NULL,
	`iduser`	INTEGER,
	`username`	text,
	`createdon`	datetime NOT NULL DEFAULT current_timestamp,
	`lastmodifiedon`	datetime NOT NULL,
	`fullrequired`	bigint NOT NULL DEFAULT 1,
	CONSTRAINT `sqlite_master_PK_orderh` PRIMARY KEY(`idorderh`)
);
CREATE TABLE IF NOT EXISTS `order` (
	`idorder`	INTEGER NOT NULL,
	`idpriority`	INTEGER NOT NULL DEFAULT 1,
	`progress`	INTEGER NOT NULL DEFAULT 0,
	`idgate`	INTEGER NOT NULL DEFAULT 1,
	`idtrack`	INTEGER NOT NULL DEFAULT 0,
	`idcategory`	INTEGER NOT NULL DEFAULT 0,
	`description`	text NOT NULL,
	`iduser`	INTEGER NOT NULL,
	`username`	TEXT NOT NULL,
	`createdon`	datetime NOT NULL DEFAULT current_timestamp,
	`lastmodifiedon`	datetime NOT NULL DEFAULT current_timestamp,
	`fullrequired`	bigint NOT NULL DEFAULT 1,
	CONSTRAINT `sqlite_master_PK_order` PRIMARY KEY(`idorder`)
);
CREATE TABLE IF NOT EXISTS `fiscalperiod` (
	`idfiscalperiod`	INTEGER NOT NULL,
	`fiscalname`	TEXT NOT NULL,
	`seq`	INTEGER NOT NULL DEFAULT 0,
	`createon`	datetime NOT NULL DEFAULT current_timestamp,
	`lastmodifiedon`	datetime NOT NULL DEFAULT current_timestamp,
	`isclosed`	bigint NOT NULL DEFAULT 0,
	CONSTRAINT `sqlite_master_PK_fiscalperiod` PRIMARY KEY(`idfiscalperiod`)
);
CREATE TABLE IF NOT EXISTS `financial` (
	`idfinancial`	INTEGER NOT NULL,
	`taxincluded`	bigint NOT NULL DEFAULT 0,
	`taxpercentage`	NUMERIC NOT NULL,
	`castgroup`	TEXT NOT NULL DEFAULT '',
	`createon`	datetime NOT NULL DEFAULT current_timestamp,
	`lastmodifiedon`	datetime NOT NULL DEFAULT current_timestamp,
	CONSTRAINT `sqlite_master_PK_financial` PRIMARY KEY(`idfinancial`)
);
CREATE TABLE IF NOT EXISTS `cartdetail_h` (
	`idcartdetailh`	INTEGER NOT NULL,
	`idcartdetail`	INTEGER NOT NULL,
	`idcart`	INTEGER NOT NULL,
	`idproduct`	INTEGER NOT NULL,
	`productcode`	text NOT NULL,
	`productname`	text NOT NULL,
	`orderquantity`	INTEGER NOT NULL,
	`idcurrencyfrom`	text NOT NULL DEFAULT '',
	`idcurrencyto`	text NOT NULL DEFAULT '',
	`rateconv`	NUMERIC NOT NULL DEFAULT 0,
	`saleprice`	NUMERIC NOT NULL DEFAULT 0,
	`iduser`	INTEGER NOT NULL,
	`username`	TEXT NOT NULL,
	`lastmodifiedon`	datetime NOT NULL,
	`createdon`	datetime NOT NULL DEFAULT current_timestamp,
	CONSTRAINT `sqlite_master_PK_cartdetailh` PRIMARY KEY(`idcartdetailh`)
);
CREATE TABLE IF NOT EXISTS `cartdetail` (
	`idcartdetail`	INTEGER NOT NULL,
	`idcart`	INTEGER NOT NULL,
	`idproduct`	INTEGER NOT NULL,
	`productcode`	text NOT NULL,
	`productname`	text NOT NULL,
	`orderquantity`	INTEGER NOT NULL DEFAULT 0,
	`idcurrencyfrom`	text NOT NULL DEFAULT '',
	`idcurrencyto`	text NOT NULL DEFAULT '',
	`rateconv`	NUMERIC NOT NULL DEFAULT 0,
	`saleprice`	NUMERIC NOT NULL DEFAULT 0,
	`iduser`	INTEGER NOT NULL,
	`username`	TEXT NOT NULL,
	`createdon`	datetime NOT NULL DEFAULT current_timestamp,
	`lastmodifiedon`	datetime NOT NULL DEFAULT current_timestamp,
	FOREIGN KEY(`idproduct`) REFERENCES `product`(`idproduct`),
	CONSTRAINT `sqlite_master_PK_cartdetail` PRIMARY KEY(`idcartdetail`),
	FOREIGN KEY(`idcart`) REFERENCES `cart`(`idcart`)
);
CREATE TABLE IF NOT EXISTS `cart_h` (
	`idcarth`	INTEGER NOT NULL,
	`idcart`	INTEGER NOT NULL,
	`idgate`	INTEGER NOT NULL,
	`description`	text NOT NULL,
	`idorder`	INTERGER NOT NULL DEFAULT 0,
	`iduser`	INTEGER NOT NULL,
	`username`	TEXT NOT NULL,
	`lastmodifiedon`	datetime NOT NULL,
	`createdon`	datetime NOT NULL DEFAULT current_timestamp,
	CONSTRAINT `sqlite_master_PK_carth` PRIMARY KEY(`idcarth`)
);
CREATE TABLE IF NOT EXISTS `cart` (
	`idcart`	INTEGER NOT NULL,
	`idgate`	INTEGER NOT NULL DEFAULT 1,
	`description`	text NOT NULL,
	`idorder`	INTEGER NOT NULL DEFAULT 0,
	`iduser`	INTEGER NOT NULL,
	`username`	TEXT NOT NULL,
	`createdon`	datetime NOT NULL DEFAULT current_timestamp,
	`lastmodifiedon`	datetime NOT NULL DEFAULT current_timestamp,
	CONSTRAINT `sqlite_master_PK_cart` PRIMARY KEY(`idcart`)
);
CREATE TABLE IF NOT EXISTS `budgetjournal_h` (
	`idbjh`	INTEGER NOT NULL,
	`idbj`	INTEGER NOT NULL,
	`idbb`	INTEGER NOT NULL,
	`castgroup`	TEXT,
	`idperiod`	INTEGER,
	`idproduct`	INTEGER,
	`periodvalue`	NUMERIC,
	`lastmodifiedon`	datetime NOT NULL,
	`createdon`	datetime NOT NULL DEFAULT current_timestamp,
	CONSTRAINT `sqlite_master_PK_budgetjournal_h` PRIMARY KEY(`idbjh`)
);
CREATE TABLE IF NOT EXISTS `budgetjournal` (
	`idbj`	INTEGER NOT NULL,
	`idbb`	INTEGER NOT NULL,
	`idperiod`	INTEGER NOT NULL,
	`idproduct`	INTEGER,
	`periodvalue`	NUMERIC NOT NULL DEFAULT 0,
	`createdon`	datetime NOT NULL DEFAULT current_timestamp,
	`lastmodifiedon`	datetime NOT NULL DEFAULT current_timestamp,
	`idfiscalperiod`	INTEGER NOT NULL,
	CONSTRAINT `sqlite_master_PK_budgetjournal` PRIMARY KEY(`idbj`),
	FOREIGN KEY(`idfiscalperiod`) REFERENCES `fiscalperiod`(`idfiscalperiod`)
);
CREATE UNIQUE INDEX IF NOT EXISTS `budgetjournal_period` ON `budgetjournal` (
	`idbb`,
	`idperiod`,
	`idproduct`
);
CREATE TRIGGER productpaytype BEFORE UPDATE ON productpaytype BEGIN UPDATE productpaytype SET lastmodifiedon = current_timestamp WHERE idproductpaytype = new.idproductpaytype; END;
CREATE TRIGGER productdetail_d BEFORE DELETE ON productdetail BEGIN INSERT INTO productdetail_h (idproduct,productdescription,productmanifest,idcurrency,saleprice,iduser,username,lastmodifiedon) VALUES(OLD.idproduct,OLD.productdescription,OLD.productmanifest,OLD.idcurrency,OLD.saleprice,OLD.iduser,OLD.username,OLD.createdon); END;
CREATE TRIGGER productdetail BEFORE UPDATE ON productdetail BEGIN INSERT INTO productdetail_h (idproduct,productdescription,productmanifest,idcurrency,saleprice,iduser,username,lastmodifiedon) VALUES(OLD.idproduct,OLD.productdescription,OLD.productmanifest,OLD.idcurrency,OLD.saleprice,OLD.iduser,OLD.username,OLD.lastmodifiedon); UPDATE productdetail SET lastmodifiedon = current_timestamp WHERE idproduct = new.idproduct; END;
CREATE TRIGGER product_d BEFORE DELETE ON product BEGIN INSERT INTO product_h (idproduct,keycode,name,inactive,deleted,idproject,srcidproduct,issales,ispurchase,tags,iduser,username,lastmodifiedon) VALUES(OLD.idproduct,OLD.keycode,OLD.name,OLD.inactive,OLD.deleted,OLD.idproject,OLD.srcidproduct,OLD.issales,OLD.ispurchase,OLD.tags,OLD.iduser,OLD.username,OLD.createdon); END;
CREATE TRIGGER product BEFORE UPDATE ON product BEGIN INSERT INTO product_h (idproduct,keycode,name,inactive,deleted,idproject,srcidproduct,issales,ispurchase,tags,iduser,username,lastmodifiedon) VALUES(OLD.idproduct,OLD.keycode,OLD.name,OLD.inactive,OLD.deleted,OLD.idproject,OLD.srcidproduct,OLD.issales,OLD.ispurchase,OLD.tags,OLD.iduser,OLD.username,OLD.lastmodifiedon); UPDATE product SET lastmodifiedon = current_timestamp WHERE idproduct = new.idproduct; END;
CREATE TRIGGER orderfulfill_d BEFORE DELETE ON orderfulfill BEGIN INSERT INTO orderfulfill_h (idorderfulfill,idorderdetail,qtyfulfill,iduser,username,lastmodifiedon) VALUES(OLD.idorderfulfill,OLD.idorderdetail,OLD.qtyfulfill,OLD.iduser,OLD.username,OLD.createdon);END;
CREATE TRIGGER orderfulfill BEFORE UPDATE ON orderfulfill BEGIN INSERT INTO orderfulfill_h (idorderfulfill,idorderdetail,qtyfulfill,iduser,username,lastmodifiedon) VALUES(OLD.idorderfulfill,OLD.idorderdetail,OLD.qtyfulfill,OLD.iduser,OLD.username,OLD.lastmodifiedon); UPDATE orderfulfill SET lastmodifiedon = current_timestamp WHERE idorderfulfill = new.idorderfulfill;END;
CREATE TRIGGER orderdetail_d BEFORE DELETE ON orderdetail BEGIN INSERT INTO orderdetail_h (idorderdetail,idorder,idproduct,srcidproduct,idproject,productcode,productname,orderquantity,productdescription,productmanifest,idcurrencyfrom,idcurrencyto,rateconv,saleprice,lastmodifiedon) VALUES(OLD.idorderdetail,OLD.idorder,OLD.idproduct,OLD.srcidproduct,OLD.idproject,OLD.productcode,OLD.productname,OLD.orderquantity,OLD.productdescription,OLD.productmanifest,OLD.idcurrencyfrom,OLD.idcurrencyto,OLD.rateconv,OLD.saleprice,OLD.createdon); END;
CREATE TRIGGER orderdetail BEFORE UPDATE ON orderdetail BEGIN INSERT INTO orderdetail_h (idorderdetail,idorder,idproduct,srcidproduct,idproject,productcode,productname,orderquantity,productdescription,productmanifest,idcurrencyfrom,idcurrencyto,rateconv,saleprice,lastmodifiedon) VALUES(OLD.idorderdetail,OLD.idorder,OLD.idproduct,OLD.srcidproduct,OLD.idproject,OLD.productcode,OLD.productname,OLD.orderquantity,OLD.productdescription,OLD.productmanifest,OLD.idcurrencyfrom,OLD.idcurrencyto,OLD.rateconv,OLD.saleprice,OLD.lastmodifiedon); UPDATE orderdetail SET lastmodifiedon = current_timestamp WHERE idorderdetail = new.idorderdetail;END;
CREATE TRIGGER order_d BEFORE DELETE ON 'order' BEGIN INSERT INTO order_h (idorder,idpriority,progress,idgate,idtrack,idcategory,description,fullrequired,iduser,username,lastmodifiedon) VALUES(OLD.idorder,OLD.idpriority,OLD.progress,OLD.idgate,OLD.idtrack,OLD.idcategory,OLD.description,OLD.fullrequired,OLD.iduser,OLD.username,OLD.createdon); END;
CREATE TRIGGER 'order' BEFORE UPDATE ON 'order' BEGIN INSERT INTO order_h (idorder,idpriority,progress,idgate,idtrack,idcategory,description,fullrequired,iduser,username,lastmodifiedon) VALUES(OLD.idorder,OLD.idpriority,OLD.progress,OLD.idgate,OLD.idtrack,OLD.idcategory,OLD.description,OLD.fullrequired,OLD.iduser,OLD.username,OLD.lastmodifiedon);UPDATE 'order' SET lastmodifiedon = current_timestamp WHERE idorder = new.idorder; END;
CREATE TRIGGER fiscalperiod BEFORE UPDATE ON fiscalperiod BEGIN UPDATE fiscalperiod SET lastmodifiedon = current_timestamp WHERE idfiscalperiod = new.idfiscalperiod; END;
CREATE TRIGGER financial BEFORE UPDATE ON financial BEGIN UPDATE financial SET lastmodifiedon = current_timestamp WHERE idfinancial = new.idfinancial; END;
CREATE TRIGGER cartdetail_d BEFORE DELETE ON cartdetail BEGIN INSERT INTO cartdetail_h (idcartdetail,idcart,idproduct,productcode,productname,orderquantity,idcurrencyfrom,idcurrencyto,rateconv,saleprice,iduser,username,lastmodifiedon) VALUES(OLD.idcartdetail,OLD.idcart,OLD.idproduct,OLD.productcode,OLD.productname,OLD.orderquantity,OLD.idcurrencyfrom,OLD.idcurrencyto,OLD.rateconv,OLD.saleprice,OLD.iduser,OLD.username,OLD.createdon); END;
CREATE TRIGGER cartdetail BEFORE UPDATE ON cartdetail BEGIN INSERT INTO cartdetail_h (idcartdetail,idcart,idproduct,productcode,productname,orderquantity,idcurrencyfrom,idcurrencyto,rateconv,saleprice,iduser,username,lastmodifiedon) VALUES(OLD.idcartdetail,OLD.idcart,OLD.idproduct,OLD.productcode,OLD.productname,OLD.orderquantity,OLD.idcurrencyfrom,OLD.idcurrencyto,OLD.rateconv,OLD.saleprice,OLD.iduser,OLD.username,OLD.lastmodifiedon); UPDATE cartdetail SET lastmodifiedon = current_timestamp WHERE idcartdetail = new.idcartdetail;END;
CREATE TRIGGER cart_d
BEFORE DELETE ON cart
BEGIN INSERT INTO cart_h (idcart,idgate,description,idorder,iduser,username,lastmodifiedon) VALUES(OLD.idcart,OLD.idgate,OLD.description,OLD.idorder,OLD.iduser,OLD.username,OLD.createdon);
END;
CREATE TRIGGER cart BEFORE UPDATE ON cart BEGIN INSERT INTO cart_h (idcart,idgate,description,idorder,iduser,username,lastmodifiedon) VALUES(OLD.idcart,OLD.idgate,OLD.description,OLD.idorder,OLD.iduser,OLD.username,OLD.lastmodifiedon); UPDATE cart SET lastmodifiedon = current_timestamp WHERE idcart = new.idcart;END;
CREATE TRIGGER budgetjournal_d BEFORE DELETE ON budgetjournal BEGIN INSERT INTO budgetjournal_h (idbj,idbb,castgroup,idperiod,periodvalue,idproduct,lastmodifiedon) VALUES(OLD.idbj,OLD.idbb,OLD.castgroup,OLD.idperiod,OLD.periodvalue,OLD.idproduct,OLD.createdon);END;
CREATE TRIGGER budgetjournal BEFORE UPDATE ON budgetjournal BEGIN INSERT INTO budgetjournal_h (idbj,idbb,castgroup,idperiod,idproduct,periodvalue,lastmodifiedon) VALUES(OLD.idbj,OLD.idbb,OLD.castgroup,OLD.idperiod,OLD.idproduct,OLD.periodvalue,OLD.lastmodifiedon); UPDATE budgetjournal SET lastmodifiedon = current_timestamp WHERE idbj = new.idbj;END;
COMMIT;
