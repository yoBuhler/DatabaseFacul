create table log_aluno (
    id int NOT NULL primary key AUTO_INCREMENT,
    nome varchar(50),
    idade int,
    matricula varchar(10),
    action varchar(50)
);

create table log_funcionario(
    id int NOT NULL primary key AUTO_INCREMENT,
    nome varchar(50),
    salario float(50),
    cargo varchar(50),
    gestor int not null,
    foreign key (gestor) REFERENCES funcionario(id),
    action varchar(50)
);

create table log_sala(
    id int NOT NULL primary key AUTO_INCREMENT,
    responsavel int not null,
    foreign key (responsavel) REFERENCES funcionario(id),
    action varchar(50)
);

create table log_disciplina(
    id int NOT NULL primary key AUTO_INCREMENT,
    professor int not null,
    nome varchar(50),
    foreign key (professor) REFERENCES disciplina(id),
    action varchar(50)
);

create table log_disciplina_aluno(
    id int NOT NULL primary key AUTO_INCREMENT,
    disciplina int not null,
    aluno int not null,
    foreign key (disciplina) REFERENCES disciplina(id),
    foreign key (aluno) REFERENCES aluno(id),
    action varchar(50)
);

create table log_nota(
    id int NOT NULL primary key AUTO_INCREMENT,
    disciplina int not null,
    aluno int not null,
    valor float,
    foreign key (disciplina) REFERENCES disciplina(id),
    foreign key (aluno) REFERENCES aluno(id),
    action varchar(50)
);


DELIMITER $

CREATE TRIGGER Trigger_Log_Aluno

AFTER INSERT ON aluno

FOR EACH ROW

BEGIN

	INSERT INTO log_aluno (nome, idade, matricula, action) VALUES (NEW.nome, NEW.idade, NEW.matricula, 'INS'); 

END$



CREATE TRIGGER Trigger_Log_Aluno2 AFTER UPDATE ON aluno

FOR EACH ROW

BEGIN 

	INSERT INTO log_aluno (nome, idade, matricula, action) VALUES (OLD.nome, OLD.idade, OLD.matricula, 'CHANGE');

END$

CREATE TRIGGER Trigger_Log_Aluno3 AFTER DELETE ON aluno

FOR EACH ROW

BEGIN 

	INSERT INTO log_aluno (nome, idade, matricula, action) 

    VALUES (OLD.nome, OLD.idade, OLD.matricula, 'DEL');

END$

CREATE TRIGGER Trigger_Log_Funcionario

AFTER INSERT ON funcionario

FOR EACH ROW

BEGIN

	INSERT INTO log_funcionario (nome, salario, cargo, gestor, action) VALUES (NEW.nome, NEW.salario, NEW.cargo, NEW.gestor, 'INS'); 

END$



CREATE TRIGGER Trigger_Log_Funcionario2 AFTER UPDATE ON funcionario

FOR EACH ROW

BEGIN 

	INSERT INTO log_funcionario (nome, salario, cargo, gestor, action) VALUES (OLD.nome, OLD.salario, OLD.cargo, OLD.gestor, 'CHANGE');

END$

CREATE TRIGGER Trigger_Log_Funcionario3 AFTER DELETE ON funcionario

FOR EACH ROW

BEGIN 

	INSERT INTO log_funcionario (nome, salario, cargo, gestor, action) 

    VALUES (OLD.nome, OLD.salario, OLD.cargo, OLD.gestor, 'DEL');

END$

CREATE TRIGGER Trigger_Log_Sala

AFTER INSERT ON sala

FOR EACH ROW

BEGIN

	INSERT INTO log_sala (responsavel, action) VALUES (NEW.responsavel, 'INS'); 

END$



CREATE TRIGGER Trigger_Log_Sala2 AFTER UPDATE ON sala

FOR EACH ROW

BEGIN 

	INSERT INTO log_sala (responsavel, action) VALUES (OLD.responsavel, 'CHANGE');

END$

CREATE TRIGGER Trigger_Log_Sala3 AFTER DELETE ON sala

FOR EACH ROW

BEGIN 

	INSERT INTO log_sala (responsavel, action) 

    VALUES (OLD.responsavel, 'DEL');

END$

CREATE TRIGGER Trigger_Log_Disciplina

AFTER INSERT ON disciplina

FOR EACH ROW

BEGIN

	INSERT INTO log_disciplina (professor, nome, action) VALUES (NEW.professor, NEW.nome, 'INS'); 

END$



CREATE TRIGGER Trigger_Log_Disciplina2 AFTER UPDATE ON disciplina

FOR EACH ROW

BEGIN 

	INSERT INTO log_disciplina (professor, nome, action) VALUES (OLD.professor, OLD.nome, 'CHANGE');

END$

CREATE TRIGGER Trigger_Log_Disciplina3 AFTER DELETE ON disciplina

FOR EACH ROW

BEGIN 

	INSERT INTO log_disciplina (professor, nome, action) 

    VALUES (OLD.professor, OLD.nome, 'DEL');

END$

CREATE TRIGGER Trigger_Log_Disciplina_aluno

AFTER INSERT ON disciplina_aluno

FOR EACH ROW

BEGIN

	INSERT INTO log_disciplina_aluno (disciplina, aluno, action) VALUES (NEW.disciplina, NEW.aluno, 'INS'); 

END$



CREATE TRIGGER Trigger_Log_Disciplina_aluno2 AFTER UPDATE ON disciplina

FOR EACH ROW

BEGIN 

	INSERT INTO log_disciplina_aluno (disciplina, aluno, action) VALUES (OLD.disciplina, OLD.aluno, 'CHANGE');

END$

CREATE TRIGGER Trigger_Log_Disciplina_aluno3 AFTER DELETE ON disciplina

FOR EACH ROW

BEGIN 

	INSERT INTO log_disciplina_aluno (disciplina, aluno, action) 

    VALUES (OLD.disciplina, OLD.aluno, 'DEL');

END$

CREATE TRIGGER Trigger_Log_Nota

AFTER INSERT ON nota

FOR EACH ROW

BEGIN

	INSERT INTO log_nota (disciplina, aluno, valor, action) VALUES (NEW.disciplina, NEW.aluno, NEW.valor, 'INS'); 

END$



CREATE TRIGGER Trigger_Log_Nota2 AFTER UPDATE ON nota

FOR EACH ROW

BEGIN 

	INSERT INTO log_nota (disciplina, aluno, valor, action) VALUES (OLD.disciplina, OLD.aluno, OLD.valor, 'CHANGE');

END$

CREATE TRIGGER Trigger_Log_Nota3 AFTER DELETE ON nota

FOR EACH ROW

BEGIN 

	INSERT INTO log_nota (disciplina, aluno, valor, action) 

    VALUES (OLD.disciplina, OLD.aluno, OLD.valor, 'DEL');

END$
DELIMITER ;