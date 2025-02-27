CREATE TABLE persons (
	id int NOT NULL,
	name varchar(255) NOT NULL,
	surname varchar(255) NOT NULL,
	password varchar(64)
);

CREATE TABLE institutes (
	id int NOT NULL,
	name varchar(255)
);

CREATE TABLE documents (
	id int NOT NULL,
	title varchar(255) NOT NULL,
	abstract varchar(255)
);

CREATE TABLE authors_docs (
	pers_id int NOT NULL,
	doc_id int NOT NULL
);

CREATE TABLE phones (
	id int NOT NULL ,
	phone varchar(255) NOT NULL ,
	pers_id int NOT NULL 
);

CREATE TABLE certs (
	id int NOT NULL ,
	cert LONGBLOB NOT NULL,
	pers_id int NOT NULL 
);

ALTER TABLE authors_docs  ADD 
	CONSTRAINT PK_authors_docs PRIMARY KEY  
	(
		pers_id,
		doc_id
	);

ALTER TABLE documents  ADD 
	CONSTRAINT PK_documents PRIMARY KEY  
	(
		id
	); 

ALTER TABLE institutes  ADD 
	CONSTRAINT PK_institutes PRIMARY KEY  
	(
		id
	);  


ALTER TABLE persons  ADD 
	CONSTRAINT PK_persons PRIMARY KEY  
	(
		id
	); 

ALTER TABLE phones  ADD 
	CONSTRAINT PK_phones PRIMARY KEY  
	(
		id
	); 

ALTER TABLE certs  ADD 
	CONSTRAINT PK_certs PRIMARY KEY  
	(
		id
	); 

CREATE TABLE referrals (
	id int NOT NULL,
	name varchar(255) NOT NULL,
	url varchar(255) NOT NULL
);

insert into institutes (id,name) values (1,'Example');

insert into persons (id,name,surname,password) values (1,'Mitya','Kovalev','mit');
insert into persons (id,name,surname) values (2,'Torvlobnor','Puzdoy');
insert into persons (id,name,surname) values (3,'Akakiy','Zinberstein');

insert into phones (id,phone,pers_id) values (1,'332-2334',1);
insert into phones (id,phone,pers_id) values (2,'222-3234',1);
insert into phones (id,phone,pers_id) values (3,'545-4563',2);

insert into documents (id,abstract,title) values (1,'abstract1','book1');
insert into documents (id,abstract,title) values (2,'abstract2','book2');

insert into authors_docs (pers_id,doc_id) values (1,1);
insert into authors_docs (pers_id,doc_id) values (1,2);
insert into authors_docs (pers_id,doc_id) values (2,1);

insert into referrals (id,name,url) values (1,'Referral','ldap://localhost:9012/');

insert into certs (id,cert,pers_id) values (1,UNHEX('3082036b308202d4a003020102020102300d06092a864886f70d01010405003077310b3009060355040613025553311330110603550408130a43616c69666f726e6961311f301d060355040a13164f70656e4c444150204578616d706c652c204c74642e311330110603550403130a4578616d706c65204341311d301b06092a864886f70d010901160e6361406578616d706c652e636f6d301e170d3033313031373136333331395a170d3034313031363136333331395a307e310b3009060355040613025553311330110603550408130a43616c69666f726e6961311f301d060355040a13164f70656e4c444150204578616d706c652c204c74642e311830160603550403130f557273756c612048616d7073746572311f301d06092a864886f70d01090116107568616d406578616d706c652e636f6d30819f300d06092a864886f70d010101050003818d0030818902818100eec60a7910b57d2e687158ca55eea738d36f10413dfecf31435e1aeeb9713b8e2da7dd2dde6bc6cec03b4987eaa7b037b9eb50e11c71e58088cc282883122cd8329c6f24f6045e6be9d21b9190c8292998267a5f7905292de936262747ab4b76a88a63872c41629a69d32e894d44c896a8d06fab0a1bc7de343c6c1458478f290203010001a381ff3081fc30090603551d1304023000302c06096086480186f842010d041f161d4f70656e53534c2047656e657261746564204365727469666963617465301d0603551d0e04160414a323de136c19ae0c479450e882dfb10ad147f45e3081a10603551d2304819930819680144b6f211a3624d290f943b053472d7de1c0e69823a17ba4793077310b3009060355040613025553311330110603550408130a43616c69666f726e6961311f301d060355040a13164f70656e4c444150204578616d706c652c204c74642e311330110603550403130a4578616d706c65204341311d301b06092a864886f70d010901160e6361406578616d706c652e636f6d820100300d06092a864886f70d010104050003818100881470045bdce95660d6e6af59e6a844aec4b9f5eaea88d4eb7a5a47080afa64750f81a3e47d00fd39c69a17a1c66d29d36f06edc537107f8c592239c2d4da55fb3f1d488e7b2387ad2a551cbd1ceb070ae9e020a9467275cb28798abb4cbfff98ddb3f1e7689b067072392511bb08125b5bec2bc207b7b6b275c47248f29acd'),3);

create table ldap_oc_mappings
 (
	id integer unsigned not null primary key auto_increment,
	name varchar(64) not null,
	keytbl varchar(64) not null,
	keycol varchar(64) not null,
	create_proc varchar(255),
	delete_proc varchar(255),
	expect_return tinyint not null
);

create table ldap_attr_mappings
 (
	id integer unsigned not null primary key auto_increment,
	oc_map_id integer unsigned not null references ldap_oc_mappings(id),
	name varchar(255) not null,
	sel_expr varchar(255) not null,
	sel_expr_u varchar(255),
	from_tbls varchar(255) not null,
	join_where varchar(255),
	add_proc varchar(255),
	delete_proc varchar(255),
	param_order tinyint not null,
	expect_return tinyint not null
);

create table ldap_entries
 (
	id integer unsigned not null primary key auto_increment,
	dn varchar(255) not null,
	oc_map_id integer unsigned not null references ldap_oc_mappings(id),
	parent int NOT NULL ,
	keyval int NOT NULL 
);

alter table ldap_entries add 
	constraint unq1_ldap_entries unique
	(
		oc_map_id,
		keyval
	);  

alter table ldap_entries add
	constraint unq2_ldap_entries unique
	(
		dn
	);  

create table ldap_entry_objclasses
 (
	entry_id integer unsigned not null references ldap_entries(id),
	oc_name varchar(64)
 );

-- mappings 

-- objectClass mappings: these may be viewed as structuralObjectClass, the ones that are used to decide how to build an entry
--	id		a unique number identifying the objectClass
--	name		the name of the objectClass; it MUST match the name of an objectClass that is loaded in slapd's schema
--	keytbl		the name of the table that is referenced for the primary key of an entry
--	keycol		the name of the column in "keytbl" that contains the primary key of an entry; the pair "keytbl.keycol" uniquely identifies an entry of objectClass "id"
--	create_proc	a procedure to create the entry
--	delete_proc	a procedure to delete the entry; it takes "keytbl.keycol" of the row to be deleted
--	expect_return	a bitmap that marks whether create_proc (1) and delete_proc (2) return a value or not
insert into ldap_oc_mappings (id,name,keytbl,keycol,create_proc,delete_proc,expect_return)
values (1,'inetOrgPerson','persons','id',NULL,NULL,0);

insert into ldap_oc_mappings (id,name,keytbl,keycol,create_proc,delete_proc,expect_return)
values (2,'document','documents','id',NULL,NULL,0);

insert into ldap_oc_mappings (id,name,keytbl,keycol,create_proc,delete_proc,expect_return)
values (3,'organization','institutes','id',NULL,NULL,0);

insert into ldap_oc_mappings (id,name,keytbl,keycol,create_proc,delete_proc,expect_return)
values (4,'referral','referrals','id',NULL,NULL,0);

-- attributeType mappings: describe how an attributeType for a certain objectClass maps to the SQL data.
--	id		a unique number identifying the attribute	
--	oc_map_id	the value of "ldap_oc_mappings.id" that identifies the objectClass this attributeType is defined for
--	name		the name of the attributeType; it MUST match the name of an attributeType that is loaded in slapd's schema
--	sel_expr	the expression that is used to select this attribute (the "select <sel_expr> from ..." portion)
--	from_tbls	the expression that defines the table(s) this attribute is taken from (the "select ... from <from_tbls> where ..." portion)
--	join_where	the expression that defines the condition to select this attribute (the "select ... where <join_where> ..." portion)
--	add_proc	a procedure to insert the attribute; it takes the value of the attribute that is added, and the "keytbl.keycol" of the entry it is associated to
--	delete_proc	a procedure to delete the attribute; it takes the value of the attribute that is added, and the "keytbl.keycol" of the entry it is associated to
--	param_order	a mask that marks if the "keytbl.keycol" value comes before or after the value in add_proc (1) and delete_proc (2)
--	expect_return	a mask that marks whether add_proc (1) and delete_proc(2) are expected to return a value or not
insert into ldap_attr_mappings (id,oc_map_id,name,sel_expr,from_tbls,join_where,add_proc,delete_proc,param_order,expect_return)
values (1,1,'cn',"concat(persons.name,' ',persons.surname)",'persons',NULL,NULL,NULL,3,0);

insert into ldap_attr_mappings (id,oc_map_id,name,sel_expr,from_tbls,join_where,add_proc,delete_proc,param_order,expect_return)
values (2,1,'telephoneNumber','phones.phone','persons,phones',
        'phones.pers_id=persons.id',NULL,NULL,3,0);

insert into ldap_attr_mappings (id,oc_map_id,name,sel_expr,from_tbls,join_where,add_proc,delete_proc,param_order,expect_return)
values (3,1,'givenName','persons.name','persons',NULL,NULL,NULL,3,0);

insert into ldap_attr_mappings (id,oc_map_id,name,sel_expr,from_tbls,join_where,add_proc,delete_proc,param_order,expect_return)
values (4,1,'sn','persons.surname','persons',NULL,NULL,NULL,3,0);

insert into ldap_attr_mappings (id,oc_map_id,name,sel_expr,from_tbls,join_where,add_proc,delete_proc,param_order,expect_return)
values (5,1,'userPassword','persons.password','persons','persons.password IS NOT NULL',NULL,NULL,3,0);

insert into ldap_attr_mappings (id,oc_map_id,name,sel_expr,from_tbls,join_where,add_proc,delete_proc,param_order,expect_return)
values (6,1,'seeAlso','seeAlso.dn','ldap_entries AS seeAlso,documents,authors_docs,persons',
        'seeAlso.keyval=documents.id AND seeAlso.oc_map_id=2 AND authors_docs.doc_id=documents.id AND authors_docs.pers_id=persons.id',
	NULL,NULL,3,0);

insert into ldap_attr_mappings (id,oc_map_id,name,sel_expr,from_tbls,join_where,add_proc,delete_proc,param_order,expect_return)
values (7,2,'description','documents.abstract','documents',NULL,NULL,NULL,3,0);

insert into ldap_attr_mappings (id,oc_map_id,name,sel_expr,from_tbls,join_where,add_proc,delete_proc,param_order,expect_return)
values (8,2,'documentTitle','documents.title','documents',NULL,NULL,NULL,3,0);

insert into ldap_attr_mappings (id,oc_map_id,name,sel_expr,from_tbls,join_where,add_proc,delete_proc,param_order,expect_return)
values (9,2,'documentAuthor','documentAuthor.dn','ldap_entries AS documentAuthor,documents,authors_docs,persons',
	'documentAuthor.keyval=persons.id AND documentAuthor.oc_map_id=1 AND authors_docs.doc_id=documents.id AND authors_docs.pers_id=persons.id',
	NULL,NULL,3,0);

insert into ldap_attr_mappings (id,oc_map_id,name,sel_expr,from_tbls,join_where,add_proc,delete_proc,param_order,expect_return)
values (10,2,'documentIdentifier','concat(''document '',documents.id)','documents',NULL,NULL,NULL,3,0);

insert into ldap_attr_mappings (id,oc_map_id,name,sel_expr,from_tbls,join_where,add_proc,delete_proc,param_order,expect_return)
values (11,3,'o','institutes.name','institutes',NULL,NULL,NULL,3,0);

insert into ldap_attr_mappings (id,oc_map_id,name,sel_expr,from_tbls,join_where,add_proc,delete_proc,param_order,expect_return)
values (12,3,'dc','lower(institutes.name)','institutes,ldap_entries AS dcObject,ldap_entry_objclasses as auxObjectClass',
	'institutes.id=dcObject.keyval AND dcObject.oc_map_id=3 AND dcObject.id=auxObjectClass.entry_id AND auxObjectClass.oc_name=''dcObject''',
	NULL,NULL,3,0);

insert into ldap_attr_mappings (id,oc_map_id,name,sel_expr,from_tbls,join_where,add_proc,delete_proc,param_order,expect_return)
values (13,4,'ou','referrals.name','referrals',NULL,NULL,NULL,3,0);

insert into ldap_attr_mappings (id,oc_map_id,name,sel_expr,from_tbls,join_where,add_proc,delete_proc,param_order,expect_return)
values (14,4,'ref','referrals.url','referrals',NULL,NULL,NULL,3,0);

insert into ldap_attr_mappings (id,oc_map_id,name,sel_expr,from_tbls,join_where,add_proc,delete_proc,param_order,expect_return)
values (15,1,'userCertificate','certs.cert','persons,certs',
        'certs.pers_id=persons.id',NULL,NULL,3,0);

-- entries mapping: each entry must appear in this table, with a unique DN rooted at the database naming context
--	id		a unique number > 0 identifying the entry
--	dn		the DN of the entry, in "pretty" form
--	oc_map_id	the "ldap_oc_mappings.id" of the main objectClass of this entry (view it as the structuralObjectClass)
--	parent		the "ldap_entries.id" of the parent of this objectClass; 0 if it is the "suffix" of the database
--	keyval		the value of the "keytbl.keycol" defined for this objectClass
insert into ldap_entries (id,dn,oc_map_id,parent,keyval)
values (1,'dc=example,dc=com',3,0,1);

insert into ldap_entries (id,dn,oc_map_id,parent,keyval)
values (2,'cn=Mitya Kovalev,dc=example,dc=com',1,1,1);

insert into ldap_entries (id,dn,oc_map_id,parent,keyval)
values (3,'cn=Torvlobnor Puzdoy,dc=example,dc=com',1,1,2);

insert into ldap_entries (id,dn,oc_map_id,parent,keyval)
values (4,'cn=Akakiy Zinberstein,dc=example,dc=com',1,1,3);

insert into ldap_entries (id,dn,oc_map_id,parent,keyval)
values (5,'documentTitle=book1,dc=example,dc=com',2,1,1);

insert into ldap_entries (id,dn,oc_map_id,parent,keyval)
values (6,'documentTitle=book2,dc=example,dc=com',2,1,2);

insert into ldap_entries (id,dn,oc_map_id,parent,keyval)
values (7,'ou=Referral,dc=example,dc=com',4,1,1);

-- objectClass mapping: entries that have multiple objectClass instances are listed here with the objectClass name (view them as auxiliary objectClass)
--	entry_id	the "ldap_entries.id" of the entry this objectClass value must be added
--	oc_name		the name of the objectClass; it MUST match the name of an objectClass that is loaded in slapd's schema
insert into ldap_entry_objclasses (entry_id,oc_name)
values (1,'dcObject');

insert into ldap_entry_objclasses (entry_id,oc_name)
values (4,'pkiUser');

insert into ldap_entry_objclasses (entry_id,oc_name)
values (7,'extensibleObject');



