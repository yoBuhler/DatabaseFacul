create table log_funcionario_with_gestor_name (
    id int NOT NULL primary key AUTO_INCREMENT,
    nome varchar(50),
    salario float(50),
    cargo varchar(50),
    gestor varchar(50),
    action varchar(50)
);

DELIMITER $ 

CREATE TRIGGER Trigger_Log_Funcionario_with_gestor_name

AFTER INSERT ON funcionario

FOR EACH ROW 

BEGIN 

	SET @NOME_GESTOR := (SELECT nome from funcionario WHERE id = NEW.gestor);

    

	INSERT INTO log_funcionario_with_gestor_name (nome, salario, cargo, gestor, acao) 

    VALUES (NEW.nome, NEW.salario, NEW.cargo, @NOME_GESTOR, 'INS'); 



END$



CREATE TRIGGER Trigger_Log_Funcionario_with_gestor_name2 AFTER UPDATE ON funcionario

FOR EACH ROW

BEGIN 

    SET @NOME_GESTOR := (SELECT nome from funcionario WHERE id = NEW.gestor);

    

    INSERT INTO log_funcionario_with_gestor_name (nome, salario, cargo, gestor, acao) 

    VALUES (NEW.nome, NEW.salario, NEW.cargo, @NOME_GESTOR, 'CHANGE'); 

    

END$



CREATE TRIGGER Trigger_Log_Funcionario_with_gestor_name3 AFTER DELETE ON funcionario

FOR EACH ROW

BEGIN 

	SET @NOME_GESTOR := (SELECT nome from funcionario WHERE id = OLD.gestor);

    

	INSERT INTO log_funcionario_with_gestor_name (nome, salario, cargo, gestor, acao)  

    VALUES (DEL.nome, DEL.salario, DEL.cargo, @NOME_GESTOR, 'DEL');

    

END$

DELIMITER ; 