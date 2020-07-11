/* 1. Criar um banco de dados para um sistema de consultas médicas */

create database consultorio;
use consultorio;

/* 2. Dados mandatórios */

/* 2.1. Médicos da clínica (nome, crm (formato UF/NUMERO), convênios que atende) */

create table medico(
    id int not null primary key auto_increment,
    nome varchar(100),
    crm varchar(50)
);

/* 2.2. Convênios (nome do convênio) */

create table convenio(
    id int not null primary key auto_increment,
    nome varchar(100)
);

/* 5. Quando cadastrar uma consulta, registrar qual é o convênio utilizado. (Extra: não pode marcar consulta por um convênio que o médico não atenda) */

create table medico_convenio(
    id int not null primary key auto_increment,
    id_medico int,
    id_convenio int,
    foreign key (id_medico) references medico (id),
    foreign key (id_convenio) references convenio (id)
);

/* 2.3. Pacientes (cadastro - Nome, CPF, Telefone) */

create table paciente(
    id int not null primary key auto_increment,
    nome varchar(50),
    cpf varchar(11),
    telefone varchar(11)
);

/* 2.4. Consulta (médico, paciente, data, hora, convênio) */

create table consulta(
    id int not null primary key auto_increment,
    id_medico_convenio int,
    id_paciente int,
    data_da_consulta datetime,
    foreign key (id_medico_convenio) references medico_convenio(id)
);

/* 2.5. Prontuário (consulta, texto do prontuário) */

create table prontuario(
    id int not null primary key auto_increment,
    id_consulta int,
    texto_prontuario varchar(1000),
    foreign key (id_consulta) references consulta (id)
);

insert into medico(nome, crm) values ("Humberto Cançado", "9134 MG");
insert into medico(nome, crm) values ("Renata Bruno", "17117 MG");
insert into medico(nome, crm) values ("Paulo Augusto", "24456 MG");

insert into convenio(nome) values ("Particular");
insert into convenio(nome) values ("Unimed");
insert into convenio(nome) values ("Clinipam");

/* 3. Vincular os médicos com os convênios que atende (um médico pode atender um ou vários) */

/* 4. Cadastrar um convênio "PARTICULAR". Esse, todos os médicos devem atender. */

/* 5. Quando cadastrar uma consulta, registrar qual é o convênio utilizado. (Extra: não pode marcar consulta por um convênio que o médico não atenda) */

insert into medico_convenio(id_medico, id_convenio) values (1, 1);
insert into medico_convenio(id_medico, id_convenio) values (2, 1);
insert into medico_convenio(id_medico, id_convenio) values (3, 1);
insert into medico_convenio(id_medico, id_convenio) values (1, 2);
insert into medico_convenio(id_medico, id_convenio) values (1, 3);
insert into medico_convenio(id_medico, id_convenio) values (2, 2);
insert into medico_convenio(id_medico, id_convenio) values (3, 2);
insert into medico_convenio(id_medico, id_convenio) values (3, 3);

insert into paciente(nome, cpf, telefone) values ("Johan Kneubuhler", "04027317902", "47997928237");
insert into paciente(nome, cpf, telefone) values ("Joyce Kneubuhler", "77158498919", "4733701103");
insert into paciente(nome, cpf, telefone) values ("Jessica Kneubuhler", "75200582989", "4732766582");

insert into consulta(id_paciente, id_medico_convenio, data_da_consulta) values (1, 6, "2020-07-10 23:30:00");
insert into consulta(id_paciente, id_medico_convenio, data_da_consulta) values (1, 6, "2020-07-11 15:30:00");
insert into consulta(id_paciente, id_medico_convenio, data_da_consulta) values (1, 7, "2020-07-01 11:30:00");
insert into consulta(id_paciente, id_medico_convenio, data_da_consulta) values (1, 7, "2020-07-02 16:30:00");
insert into consulta(id_paciente, id_medico_convenio, data_da_consulta) values (1, 8, "2020-07-03 00:30:00");
insert into consulta(id_paciente, id_medico_convenio, data_da_consulta) values (1, 6, "2020-06-29 18:30:00");

insert into prontuario(id_consulta, texto_prontuario) values (1, "Johan deu a entrada no pronto socorro");
insert into prontuario(id_consulta, texto_prontuario) values (2, "Johan está ficando maluco pois queimou a mi band dele");
insert into prontuario(id_consulta, texto_prontuario) values (3, "Exame de rotina dia 01");
insert into prontuario(id_consulta, texto_prontuario) values (4, "Exame de rotina dia 02");
insert into prontuario(id_consulta, texto_prontuario) values (5, "Exame de rotina dia 03");
insert into prontuario(id_consulta, texto_prontuario) values (6, "Exame de rotina dia 29 do mês passado");

/* 6. Criar uma view que mostre os dados das consultas e prontuários */

create view consulta_prontuario_view as select medico.nome as "Médico", medico.crm as "CRM", convenio.nome as "Convênio", paciente.nome as "Paciente", consulta.data_da_consulta as "Data da cosulta", prontuario.texto_prontuario as "Prontuário" from consulta inner join prontuario on prontuario.id_consulta = consulta.id inner join medico_convenio on consulta.id_medico_convenio = medico_convenio.id inner join medico on medico.id = medico_convenio.id_medico inner join convenio on convenio.id = medico_convenio.id_convenio inner join paciente on paciente.id = consulta.id_paciente;

/* 7. Criar uma query que busque todas as consultas do ano de um determinado paciente */

select medico.nome as "Médico", medico.crm as "CRM", convenio.nome as "Convênio", paciente.nome as "Paciente", consulta.data_da_consulta as "Data da cosulta", prontuario.texto_prontuario as "Prontuário" from consulta inner join prontuario on prontuario.id_consulta = consulta.id inner join medico_convenio on consulta.id_medico_convenio = medico_convenio.id inner join medico on medico.id = medico_convenio.id_medico inner join convenio on convenio.id = medico_convenio.id_convenio inner join paciente on paciente.id = consulta.id_paciente where YEAR(consulta.data_da_consulta) = YEAR(CURDATE()) and paciente.nome = "Johan Kneubuhler";

/* 8. Criar uma query que busque todas as consultas do ano de um determinado médico */

select medico.nome as "Médico", medico.crm as "CRM", convenio.nome as "Convênio", paciente.nome as "Paciente", consulta.data_da_consulta as "Data da cosulta", prontuario.texto_prontuario as "Prontuário" from consulta inner join prontuario on prontuario.id_consulta = consulta.id inner join medico_convenio on consulta.id_medico_convenio = medico_convenio.id inner join medico on medico.id = medico_convenio.id_medico inner join convenio on convenio.id = medico_convenio.id_convenio inner join paciente on paciente.id = consulta.id_paciente where YEAR(consulta.data_da_consulta) = YEAR(CURDATE()) and medico.nome = "Renata Bruno";

/* 9. Criar uma query que busque todas as consultas do mês de um determinado médico */

select medico.nome as "Médico", medico.crm as "CRM", convenio.nome as "Convênio", paciente.nome as "Paciente", consulta.data_da_consulta as "Data da cosulta", prontuario.texto_prontuario as "Prontuário" from consulta inner join prontuario on prontuario.id_consulta = consulta.id inner join medico_convenio on consulta.id_medico_convenio = medico_convenio.id inner join medico on medico.id = medico_convenio.id_medico inner join convenio on convenio.id = medico_convenio.id_convenio inner join paciente on paciente.id = consulta.id_paciente where MONTH(consulta.data_da_consulta) = MONTH(CURDATE()) and medico.nome = "Renata Bruno";

/* 10. Criar uma query que conte quantas consultas o médico teve no mês agrupadas por convênio */

select medico.nome as "Médico", convenio.nome as "Convênio", count(consulta.id) as "Quantidade de consultas" from consulta inner join medico_convenio on consulta.id_medico_convenio = medico_convenio.id inner join medico on medico.id = medico_convenio.id_medico inner join convenio on convenio.id = medico_convenio.id_convenio where MONTH(consulta.data_da_consulta) = MONTH(CURDATE())  group by medico_convenio.id_medico, medico_convenio.id_convenio;

/* 11. Criar uma query que busque todos os prontuários de um determinado paciente */

select prontuario.texto_prontuario as "Prontuário" from consulta inner join prontuario on prontuario.id_consulta = consulta.id inner join paciente on paciente.id = consulta.id_paciente where paciente.nome = "Johan Kneubuhler";