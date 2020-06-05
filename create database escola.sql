create database escola;
use escola;

create table aluno (
    id int NOT NULL primary key AUTO_INCREMENT,
    nome varchar(50),
    idade int,
    matricula varchar(10)
);

create table funcionario(
    id int NOT NULL primary key AUTO_INCREMENT,
    nome varchar(50),
    salario float(50),
    cargo varchar(50),
    gestor int not null,
    foreign key (gestor) REFERENCES funcionario(id)
);

create table sala(
    id int NOT NULL primary key AUTO_INCREMENT,
    responsavel int not null,
    foreign key (responsavel) REFERENCES funcionario(id)
);

create table disciplina(
    id int NOT NULL primary key AUTO_INCREMENT,
    professor int not null,
    nome varchar(50),
    foreign key (professor) REFERENCES disciplina(id)
);

create table disciplina_aluno(
    id int NOT NULL primary key AUTO_INCREMENT,
    disciplina int not null,
    aluno int not null,
    foreign key (disciplina) REFERENCES disciplina(id),
    foreign key (aluno) REFERENCES aluno(id)
);

create table nota(
    id int NOT NULL primary key AUTO_INCREMENT,
    disciplina int not null,
    aluno int not null,
    valor float,
    foreign key (disciplina) REFERENCES disciplina(id),
    foreign key (aluno) REFERENCES aluno(id)
);