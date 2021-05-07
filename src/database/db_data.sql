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
INSERT INTO library.users(id,login,password,firstName,lastName,Address,Email) VALUES ('1','guest','passwd123','Guesting','Guest',Null,Null);

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
INSERT INTO db_options(id,name,server,serverip,note) VALUES ('1','Sofia University','silvipc','192.168.1.3',null);