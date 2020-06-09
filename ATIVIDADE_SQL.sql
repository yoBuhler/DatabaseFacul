create database ATIVIDADE_SQL;
use ATIVIDADE_SQL;

create table Filme(
    id int not null auto_increment primary key,
    titulo varchar(100),
    ano int,
    diretor varchar(70)
);

insert into Filme (id, titulo, ano, diretor) values (101, "E o Vento Levou", 1939, "Victor Fleming");
insert into Filme (id, titulo, ano, diretor) values (102, "Star Wars", 1977, "George Lucas");
insert into Filme (id, titulo, ano, diretor) values (103, "A Noviça Rebelde", 1965, "Robert Wise");
insert into Filme (id, titulo, ano, diretor) values (104, "E.T.", 1982, "Steven Spielberg");
insert into Filme (id, titulo, ano, diretor) values (105, "Titanic", 1997, "James Cameron");
insert into Filme (id, titulo, ano) values (106, "Branca de Neve e os Sete Anões", 1937);
insert into Filme (id, titulo, ano, diretor) values (107, "Avatar", 2009, "James Cameron");
insert into Filme (id, titulo, ano, diretor) values (108, "Os Caçadores da Arca Perdida", 1981, "Steven Spielberg");

create table Critico(
    cid int not null auto_increment primary key,
    nome varchar(100)
);

insert into Critico (cid, nome) values (201, "Sarah Martinez");
insert into Critico (cid, nome) values (202, "Daniel Lewis");
insert into Critico (cid, nome) values (203, "Brittany Harris");
insert into Critico (cid, nome) values (204, "Mike Anderson");
insert into Critico (cid, nome) values (205, "Chris Jackson");
insert into Critico (cid, nome) values (206, "Elizabeth Thomas");
insert into Critico (cid, nome) values (207, "James Cameron");
insert into Critico (cid, nome) values (208, "Ashley White");

create table Avaliacao (
    cid int not null,
    fid int not null,
    estrelas int not null,
    dataDaCritica date,
    foreign key (cid) REFERENCES Critico(cid),
    foreign key (fid) REFERENCES Filme(id)
);

insert into Avaliacao (cid, fid, estrelas, dataDaCritica) values (201, 101, 2, "2011-01-22");
insert into Avaliacao (cid, fid, estrelas, dataDaCritica) values (201, 101, 4, "2011-01-27");
insert into Avaliacao (cid, fid, estrelas, dataDaCritica) values (202, 106, 4, null);
insert into Avaliacao (cid, fid, estrelas, dataDaCritica) values (203, 103, 2, "2011-01-20");
insert into Avaliacao (cid, fid, estrelas, dataDaCritica) values (203, 108, 4, "2011-01-12");
insert into Avaliacao (cid, fid, estrelas, dataDaCritica) values (203, 108, 2, "2011-01-30");
insert into Avaliacao (cid, fid, estrelas, dataDaCritica) values (204, 101, 3, "2011-01-09");
insert into Avaliacao (cid, fid, estrelas, dataDaCritica) values (205, 103, 3, "2011-01-27");
insert into Avaliacao (cid, fid, estrelas, dataDaCritica) values (205, 104, 2, "2011-01-22");
insert into Avaliacao (cid, fid, estrelas, dataDaCritica) values (205, 106, 4, null);
insert into Avaliacao (cid, fid, estrelas, dataDaCritica) values (206, 107, 3, "2011-01-15");
insert into Avaliacao (cid, fid, estrelas, dataDaCritica) values (206, 106, 5, "2011-01-19");
insert into Avaliacao (cid, fid, estrelas, dataDaCritica) values (207, 107, 5, "2011-01-20");
insert into Avaliacao (cid, fid, estrelas, dataDaCritica) values (208, 104, 3, "2011-01-02");

-- 1. Encontre os títulos de todos os filmes dirigidos por Steven Spielberg

select titulo as `Títulos dos Filmes do Steven Spielberg` from Filme where Filme.diretor = "Steven Spielberg";

-- 2 Encontre todos os anos que têm um filme que recebeu uma nota 4 ou 5, e ordene-os de forma crescente.

select ano from Filme where exists (select fid from Avaliacao where Avaliacao.fid = Filme.id and (Avaliacao.estrelas = 4 or Avaliacao.estrelas = 5)) order by Filme.ano;

-- 3 Encontre os títulos que não possuem notas

select titulo from Filme where not exists (select fid from Avaliacao where Avaliacao.fid = Filme.id);

-- 4 Alguns críticos não informaram a data. Encontre os nomes dos críticos que não colocaram a data na avaliação.

select Critico.nome from Critico where exists (select dataDaCritica from Avaliacao where Avaliacao.cid = Critico.cid and Avaliacao.dataDaCritica is null);

-- 5 Encontre os críticos que deram nota para o filme “E o vento levou”

select Critico.nome from Critico where exists (select cid from Avaliacao where Avaliacao.cid = Critico.cid and exists (select titulo from Filme where Filme.titulo = "E o Vento Levou" and Filme.id = Avaliacao.fid));

-- 6 Para cada avaliação em que o crítico é também o diretor do filme, retorne o nome do crítico, o nome do filme e o número de estrelas

select Critico.nome, Filme.titulo, Avaliacao.estrelas from Avaliacao inner join Filme on Filme.id = Avaliacao.fid inner join Critico on Critico.cid = Avaliacao.cid where Critico.nome = Filme.diretor;

-- 7 Insira o crítico “Roger Ebert” em seu banco de dados, com um cid de 209.

insert into Critico (cid, nome) values (209, "Roger Ebert");

-- 8 Remova todas as avaliações nas quais o ano do filme é anterior a 1970 ou posterior a 2000 e a nota é menor do que 4 estrelas.

delete from Avaliacao where exists (select id from Filme where (Filme.ano < 1970 or Filme.ano > 2000) and Filme.id = Avaliacao.fid) and Avaliacao.estrelas < 4;