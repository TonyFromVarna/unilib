-- GRANT CONNECT,SELECT,UPDATE,DELETE,INSERT on dbname.*
-- create database dbname

CREATE TABLE `books` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `title` varchar(100) character set utf8 NOT NULL,
  `author` varchar(40) character set utf8 default NULL,
  `mediaType` int(10) unsigned NOT NULL,
  `genre` varchar(50) character set utf8 default NULL,
  `publisher` varchar(512) character set utf8 default NULL,
  `keywords` varchar(512) character set utf8 default NULL,
  `language` int(10) unsigned default '1',
  PRIMARY KEY  (`id`)
);

CREATE TABLE `languages` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `code` varchar(3) character set utf8 NOT NULL,
  `name` varchar(100) character set utf8 NOT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `code` (`code`)
);

CREATE TABLE `mediatypes` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `code` varchar(5) character set utf8 NOT NULL,
  `name` varchar(100) character set utf8 NOT NULL,
  `note` varchar(1024) character set utf8 default NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `code` (`code`)
);

CREATE TABLE `users` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `login` varchar(20) character set utf8 NOT NULL,
  `password` varchar(20) character set utf8 NOT NULL,
  `firstName` varchar(50) character set utf8 NOT NULL,
  `lastName` varchar(50) character set utf8 NOT NULL,
  `Address` varchar(100) character set utf8 default NULL,
  `Email` varchar(30) character set utf8 default NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `login` (`login`)
);

CREATE TABLE `loans` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `bookID` int(10) unsigned NOT NULL,
  `userID` int(10) unsigned NOT NULL,
  `loaned` datetime NOT NULL,
  PRIMARY KEY  (`id`)
);

CREATE TABLE `db_options` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `name` varchar(100) character set utf8 NOT NULL,
  `server` varchar(100) character set utf8 NOT NULL,
  `serverip` varchar(30) character set utf8 default NULL,
  `note` varchar(512) character set utf8 default NULL,
  PRIMARY KEY  (`id`)
);
