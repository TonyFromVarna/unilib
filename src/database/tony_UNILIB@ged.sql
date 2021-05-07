-- GRANT CONNECT,SELECT,UPDATE,DELETE,INSERT on dbname.*
-- create database dbname

CREATE TABLE books (
  id number(10)  NOT NULL ,
  title varchar2(100) NOT NULL,
  author varchar2(40) default NULL,
  mediaType number(10)  NOT NULL,
  genre varchar2(50) default NULL,
  publisher varchar2(512) default NULL,
  keywords varchar2(512) default NULL,
  language number(10)  default '1',
  PRIMARY KEY  (id)
);

CREATE TABLE languages (
  id number(10)  NOT NULL ,
  code varchar2(3) NOT NULL unique,
  name varchar2(100) NOT NULL,
  PRIMARY KEY  (id)
);

CREATE TABLE mediatypes (
  id number(10)  NOT NULL ,
  code varchar2(5) NOT NULL unique,
  name varchar2(100) NOT NULL,
  note varchar2(1024) default NULL,
  PRIMARY KEY  (id)
);

CREATE TABLE users (
  id number(10)  NOT NULL ,
  login varchar2(20) NOT NULL UNIQUE,
  password varchar2(20) NOT NULL,
  firstName varchar2(50) NOT NULL,
  lastName varchar2(50) NOT NULL,
  Address varchar2(100) default NULL,
  Email varchar2(30) default NULL,
  PRIMARY KEY  (id)
);

CREATE TABLE loans (
  id number(10)  NOT NULL ,
  bookID number(10)  NOT NULL,
  userID number(10)  NOT NULL,
  loaned date NOT NULL,
  PRIMARY KEY  (id)
);

CREATE TABLE db_options (
  id number(10)  NOT NULL ,
  name varchar2(100) NOT NULL,
  server varchar2(100) NOT NULL,
  serverip varchar2(30) default NULL,
  note varchar2(512) default NULL,
  PRIMARY KEY  (id)
);



-- INSERT for table books
INSERT INTO books(id,title,author,mediaType,genre,publisher,keywords,language) VALUES ('1','Atlas of Lewis and Clark in Missouri','Harlan, James','1','Geography','University of Missouri Press,2003',null,'1');
INSERT INTO books(id,title,author,mediaType,genre,publisher,keywords,language) VALUES ('2','Geography and GIS : serving our world','Sappington, Nancy R. H.','1','Geography','ESRI Press,2003',null,'1');
INSERT INTO books(id,title,author,mediaType,genre,publisher,keywords,language) VALUES ('3','Geology and health : closing the gap','Skinner, H. Catherine W. ; Berger, Anton','1','Geography','Oxford University Press,2003',null,'1');
INSERT INTO books(id,title,author,mediaType,genre,publisher,keywords,language) VALUES ('4','Guns, germs, and steel : the fates of human societies','Diamond, Jared M.','1','Geography','W.W. Norton,2003',null,'1');
INSERT INTO books(id,title,author,mediaType,genre,publisher,keywords,language) VALUES ('5','Spatial statistics and computational methods','M ller, Jesper.','1','Geography','Springer,2003',null,'1');
INSERT INTO books(id,title,author,mediaType,genre,publisher,keywords,language) VALUES ('6','Environmental geography : science, land use, and earth systems','Marsh, William M.','1','Geography','J. Wiley,2002',null,'1');
INSERT INTO books(id,title,author,mediaType,genre,publisher,keywords,language) VALUES ('7','GIS and public health','Cromley, Ellen K.','1','Geography','Guilford Press,2002',null,'1');
INSERT INTO books(id,title,author,mediaType,genre,publisher,keywords,language) VALUES ('8','Resource wars : the new landscape of global conflict','Klare, Michael T.','1','Geography','Henry Holt,2002',null,'1');


-- INSERT for table users
INSERT INTO users(id,login,password,firstName,lastName,Address,Email) 
VALUES ('1','guest','passwd123','Guesting','Guest',Null,Null);

-- INSERT for table languages
INSERT INTO languages(id,code,name) VALUES ('1','ENG','English');
INSERT INTO languages(id,code,name) VALUES ('2','BUL','Bulgarian');
INSERT INTO languages(id,code,name) VALUES ('3','RUS','Russian');

-- INSERT for table mediatypes
INSERT INTO mediatypes(id,code,name,note) VALUES ('1','BOOK','Books',null);
INSERT INTO mediatypes(id,code,name,note) VALUES ('2','JRN','Journals',null);
INSERT INTO mediatypes(id,code,name,note) VALUES ('3','MAG','Magazines',null);
INSERT INTO mediatypes(id,code,name,note) VALUES ('4','NEWS','Newspapers',null);
INSERT INTO mediatypes(id,code,name,note) VALUES ('5','ENC','Encyclopedia',null);
INSERT INTO mediatypes(id,code,name,note) VALUES ('6','DVD','Optical storage - CD Roms or DVD Roms',null);

-- INSERT for table db_options
INSERT INTO db_options(id,name,server,serverip,note) VALUES ('1','Sofia University','ged.localdomain','192.168.100.177',null);

select count(*) from users;

create sequence books_id_seq
    INCREMENT BY 1
    START WITH 9
    MINVALUE 1
    MAXVALUE 1000000
    CYCLE
    CACHE 2;

create sequence users_id_seq
    INCREMENT BY 1
    START WITH 2
    MINVALUE 1
    MAXVALUE 1000000
    CYCLE
    CACHE 2;
    
create sequence languages_id_seq
    INCREMENT BY 1
    START WITH 4
    MINVALUE 1
    MAXVALUE 1000000
    CYCLE
    CACHE 2;
    
create sequence mediatypes_seq
    INCREMENT BY 1
    START WITH 7
    MINVALUE 1
    MAXVALUE 1000000
    CYCLE
    CACHE 2;
    
create sequence db_options_seq
    INCREMENT BY 1
    START WITH 2
    MINVALUE 1
    MAXVALUE 1000000
    CYCLE
    CACHE 2;
