create database empresa;
use empresa;

create table turnos(
id int not null primary-key auto_increment
nome varchar[50],
);

create table chefes(
id int not null primary-key auto_increment,
nome varchar[50],
turno_id int,
foreign key (turno_id) REFERENCES turnos(id)
);

create table setores(
id int not null primary-key auto_increment,
nome varchar[50],
chefe_id int,
foreign key (chefe_id) REFERENCES chefes(id)
);

create table funcionarios(
id int not null primary-key auto_increment,
nome varchar[50],
idade int,
setor_id int,
turno_id int,
foreign key (setor_id) REFERENCES setores(id),
foreign key (turno_id) REFERENCES turnos(id)
);

INSERT INTO turnos (nome)
VALUES ('matutino'),('vespertino'),('noturno');

INSERT INTO chefes (nome, turno_id)
VALUES ('Johan', 1),('Ingrid', 2);

INSERT INTO setores (nome, chefe_id)
VALUES ('Motores', 2), ('Corporativo', 1);

INSERT INTO funcionarios (nome, idade, setor_id, turno_id)
VALUES ('Caio', 19, 1, 2), ('Cristhian', 19, 2, 1), ('Fernando', 19, 2, 1);

SELECT funcionarios.nome AS [FUNCIONÁRIO], funcionarios.idade AS [IDADE], setores.nome AS [SETOR], chefes.nome AS [CHEFE], turnos.nome AS [TURNO]
FROM (((funcionarios
INNER JOIN turnos ON funcionarios.turno_id = turnos.id)
INNER JOIN setores ON funcionarios.setor_id = setores.id)
INNER JOIN chefes ON chefes.id = setores.id);

/*
    O select acima retorna todos os funcionários seus respectivos nomes, idade, setores, chefes, turnos 
    Este código não foi testado
*/