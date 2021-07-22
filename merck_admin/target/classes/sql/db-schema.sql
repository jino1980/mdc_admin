DROP TABLE IF EXISTS zoro;
CREATE TABLE zoro(ID INT auto_increment, NAME VARCHAR(50), PASSWORD VARCHAR(50));

DROP TABLE IF EXISTS authorities;
CREATE TABLE authorities(ID INT auto_increment, NAME VARCHAR(50), authority VARCHAR(50));

DROP TABLE IF EXISTS board;
CREATE TABLE board (
    id INT auto_increment,
    board_content TEXT(65000),
    password varchar(50),
    writer varchar(50),
    insDate date, 
    PRIMARY KEY (id)
);