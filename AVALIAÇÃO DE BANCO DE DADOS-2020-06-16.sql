/* 1. Criar um banco de dados conforme as tabelas abaixo – gravar o arquivo SQL que cria o banco, tabelas e insere os dados e anexar junto à entrega do trabalho: */

create database prova_2020_06_16;
use prova_2020_06_16;

create table BANDAS(
    ID int not null primary key auto_increment,
    nome_banda varchar(100),
    ano_inicio int,
    pais_origem varchar(100)
);

insert into BANDAS(nome_banda, ano_inicio, pais_origem) values ("Iron Maiden", 1975, "Reino Unido");
insert into BANDAS(nome_banda, ano_inicio, pais_origem) values ("Black Sabbath", 1968, "Reino Unido");
insert into BANDAS(nome_banda, ano_inicio, pais_origem) values ("Deep Purple", 1968, "Reino Unido");
insert into BANDAS(nome_banda, ano_inicio, pais_origem) values ("Led Zeppelin", 1968, "Reino Unido");
insert into BANDAS(nome_banda, ano_inicio, pais_origem) values ("AC/DC", 1973, "Austrália");
insert into BANDAS(nome_banda, ano_inicio, pais_origem) values ("Steppenwolf", 1967, "Estados Unidos da América");
insert into BANDAS(nome_banda, ano_inicio, pais_origem) values ("Creedence Clearwater Revival", 1959, "Estados Unidos da América");
insert into BANDAS(nome_banda, ano_inicio, pais_origem) values ("Lynyrd Skynyrd", 1973, "Estados Unidos da América");

create table MUSICOS(
    ID int not null primary key auto_increment,
    nome varchar(50),
    banda_id int,
    foreign key (banda_id) references BANDAS (ID)
    on delete cascade
);

insert into MUSICOS(nome, banda_id) values ("Bruce Dickinson", 1);
insert into MUSICOS(nome, banda_id) values ("John Fogerty", 7);
insert into MUSICOS(nome, banda_id) values ("John Kay", 6);
insert into MUSICOS(nome, banda_id) values ("Angus Young", 5);
insert into MUSICOS(nome, banda_id) values ("Jimmy Page", 4);
insert into MUSICOS(nome, banda_id) values ("Robert Plant", 4 );
insert into MUSICOS(nome, banda_id) values ("Steve Harris", 1);
insert into MUSICOS(nome, banda_id) values ("Ian Gillan", 3);
insert into MUSICOS(nome, banda_id) values ("Richie Blackmore", 3);
insert into MUSICOS(nome, banda_id) values ("Ozzy Osbourne", 2);
insert into MUSICOS(nome, banda_id) values ("Tony Iommi", 2);
insert into MUSICOS(nome, banda_id) values ("Adrian Smith", 1);
insert into MUSICOS(nome, banda_id) values ("Ronnie Van Zant", 8);

create table SHOWS(
    ID int not null primary key auto_increment,
    cidade varchar(100)
) ;

insert into SHOWS(cidade) values ("Londres");
insert into SHOWS(cidade) values ("Sydney");
insert into SHOWS(cidade) values ("São Paulo");
insert into SHOWS(cidade) values ("Curitiba");
insert into SHOWS(cidade) values ("Los Angeles");
insert into SHOWS(cidade) values ("Denver");

create table SHOWS_BANDA(
    id int not null primary key auto_increment,
    banda_id int,
    cidade_id int,
    data date,
    foreign key (banda_id) references BANDAS (ID) on delete cascade,
    foreign key (cidade_id) references SHOWS (ID) on delete cascade
);

insert into SHOWS_BANDA(banda_id, cidade_id, data) values (1, 4, "2008-03-04");
insert into SHOWS_BANDA(banda_id, cidade_id, data) values (1, 1, "1983-01-01");
insert into SHOWS_BANDA(banda_id, cidade_id, data) values (1, 3, "2002-06-07");
insert into SHOWS_BANDA(banda_id, cidade_id, data) values (2, 4, "2016-11-30");
insert into SHOWS_BANDA(banda_id, cidade_id, data) values (2, 1, "1970-01-01");
insert into SHOWS_BANDA(banda_id, cidade_id, data) values (2, 2, "1973-01-02");
insert into SHOWS_BANDA(banda_id, cidade_id, data) values (3, 4, "2007-01-01");
insert into SHOWS_BANDA(banda_id, cidade_id, data) values (3, 1, "1971-02-02");
insert into SHOWS_BANDA(banda_id, cidade_id, data) values (4, 2, "1970-02-04");
insert into SHOWS_BANDA(banda_id, cidade_id, data) values (4, 5, "1972-06-06");
insert into SHOWS_BANDA(banda_id, cidade_id, data) values (5, 1, "2010-01-01");
insert into SHOWS_BANDA(banda_id, cidade_id, data) values (5, 4, "2011-02-04");
insert into SHOWS_BANDA(banda_id, cidade_id, data) values (6, 1, "1969-01-02");
insert into SHOWS_BANDA(banda_id, cidade_id, data) values (6, 5, "1970-01-06");
insert into SHOWS_BANDA(banda_id, cidade_id, data) values (7, 1, "1959-07-07");
insert into SHOWS_BANDA(banda_id, cidade_id, data) values (7, 6, "1972-10-30");
insert into SHOWS_BANDA(banda_id, cidade_id, data) values (8, 1, "1975-10-10");
insert into SHOWS_BANDA(banda_id, cidade_id, data) values (8, 5, "1977-01-10"); 

/* a. Selecionar as bandas fundadas antes de 1970 */

select * from BANDAS where ano_inicio < 1970;

/* b. Selecionar os músicos que estavam nas bandas após 1970 (somente bandas fundadas após esta data) */

select distinct MUSICOS.* from MUSICOS inner join BANDAS on MUSICOS.banda_id = BANDAS.ID where BANDAS.ano_inicio > 1970;

/* c. Selecionar artistas (músicos, não as bandas!) que tocaram na cidade de Curitiba */

select distinct MUSICOS.nome as `Nome dos músicos que se apresentarão em Curitiba` from SHOWS_BANDA inner join SHOWS on SHOWS_BANDA.cidade_id = SHOWS.ID inner join BANDAS on BANDAS.ID = SHOWS_BANDA.banda_id inner join MUSICOS on MUSICOS.banda_id = BANDAS.ID where SHOWS.cidade = "Curitiba";

/* d. Selecionar as bandas que se apresentaram em Londres entre 1980 e 2000 */

select distinct BANDAS.nome_banda as `Nome da banda que tocou em Londres entre 1980 e 2000` from SHOWS_BANDA inner join SHOWS on SHOWS_BANDA.cidade_id = SHOWS.ID inner join BANDAS on BANDAS.ID = SHOWS_BANDA.banda_id where SHOWS.cidade = "Londres" and year(SHOWS_BANDA.data) between 1980 and 2000;

/* e. Selecionar bandas que não tenham shows após 1980 */

select distinct BANDAS.* from SHOWS_BANDA inner join BANDAS on BANDAS.ID = SHOWS_BANDA.banda_id where not exists (select * from SHOWS_BANDA as `SUB_SHOWS_BANDA` where SUB_SHOWS_BANDA.banda_id = SHOWS_BANDA.banda_id and year(SUB_SHOWS_BANDA.data) > 1980);

/* f. Selecionar músicos que não se apresentaram após 2000 */

select distinct MUSICOS.* from SHOWS_BANDA inner join BANDAS on BANDAS.ID = SHOWS_BANDA.banda_id inner join MUSICOS on MUSICOS.banda_id = BANDAS.ID where not exists (select * from SHOWS_BANDA as `SUB_SHOWS_BANDA` where SUB_SHOWS_BANDA.banda_id = SHOWS_BANDA.banda_id and year(SUB_SHOWS_BANDA.data) > 2000);

/* g. Selecionar músicos que se apresentaram na década de 1970 */

select distinct MUSICOS.* from SHOWS_BANDA inner join SHOWS on SHOWS_BANDA.cidade_id = SHOWS.ID inner join BANDAS on BANDAS.ID = SHOWS_BANDA.banda_id inner join MUSICOS on MUSICOS.banda_id = BANDAS.ID where year(SHOWS_BANDA.data) between 1970 and 1979;

/* h. Selecionar bandas que nunca se apresentaram em Sydney */

select distinct BANDAS.* from SHOWS_BANDA inner join BANDAS on SHOWS_BANDA.banda_id = BANDAS.ID where not exists (select * from SHOWS_BANDA as `SUB_SHOWS_BANDA`  inner join SHOWS on SHOWS.ID = SUB_SHOWS_BANDA.cidade_id where SUB_SHOWS_BANDA.banda_id = SHOWS_BANDA.banda_id and SHOWS.cidade = "Sydney");

/* i. Excluir todas as bandas não britânicas (Reino Unido), seus músicos e seus shows */

delete SHOWS_BANDA, MUSICOS, BANDAS from SHOWS_BANDA inner join MUSICOS on MUSICOS.banda_id = SHOWS_BANDA.banda_id inner join BANDAS on SHOWS_BANDA.banda_id = BANDAS.ID where BANDAS.pais_origem != "Reino Unido";

/* j. Excluir toda a base de dados */

drop database prova_2020_06_16;