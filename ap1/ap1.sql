CREATE DATABASE ap1;
USE ap1;
drop database ap1;

CREATE TABLE pacientes(
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    cpf varchar(14) NOT NULL UNIQUE,
    data_nascimento DATE NOT NULL
);

CREATE TABLE medicos (
  id INT PRIMARY KEY AUTO_INCREMENT,
  nome VARCHAR(100) NOT NULL,
  cpf varchar(14) NOT NULL UNIQUE,
  crm varchar(8) NOT NULL UNIQUE,
  especialidade VARCHAR(100) NOT NULL
);

CREATE TABLE consultas (
  id INT PRIMARY KEY AUTO_INCREMENT,
  id_medico INT NOT NULL,
  id_paciente INT NOT NULL,
  data_consulta DATETIME NOT NULL,
  CONSTRAINT consultas_fk_medicos
        FOREIGN KEY (id_medico) REFERENCES medicos(id)
				ON DELETE RESTRICT
                ON UPDATE CASCADE,
  CONSTRAINT consultas_fk_pacientes
        FOREIGN KEY (id_paciente) REFERENCES pacientes(id)
				ON DELETE RESTRICT
                ON UPDATE CASCADE
);

CREATE TABLE prontuarios (
  id INT PRIMARY KEY AUTO_INCREMENT,
  data_registro DATETIME NOT NULL,
  descricao varchar(200) NOT NULL,
  id_paciente INT NOT NULL,
  id_medico INT NOT NULL,
  CONSTRAINT prontuarios_fk_pacientes
        FOREIGN KEY (id_paciente) REFERENCES pacientes(id)
				ON DELETE RESTRICT
                ON UPDATE CASCADE,
  CONSTRAINT prontuarios_fk_medicos
        FOREIGN KEY (id_medico) REFERENCES medicos(id)
				ON DELETE RESTRICT
                ON UPDATE CASCADE
);

CREATE TABLE exames (
  id INT PRIMARY KEY AUTO_INCREMENT,
  nome VARCHAR(100) NOT NULL,
  data_solicitacao DATE NOT NULL,
  id_prontuario INT NOT NULL,
  CONSTRAINT exames_fk_prontuarios
        FOREIGN KEY (id) REFERENCES prontuarios(id)
			ON DELETE RESTRICT
			ON UPDATE CASCADE
);

CREATE TABLE medicamentos (
  id INT PRIMARY KEY AUTO_INCREMENT,
  nome VARCHAR(100) NOT NULL,
  dosagem VARCHAR(50) NOT NULL,
  forma_administracao VARCHAR(80) NOT NULL
);

CREATE TABLE prescricoes (
  id INT PRIMARY KEY AUTO_INCREMENT,
  data_prescricao DATETIME NOT NULL,
  medicamento VARCHAR(200) NOT NULL,
  id_medico INT NOT NULL,
  id_paciente INT NOT NULL,
CONSTRAINT prescricoes_fk_pacientes
        FOREIGN KEY (id_paciente) REFERENCES pacientes(id)
			ON DELETE RESTRICT
			ON UPDATE CASCADE,
  CONSTRAINT prescricoes_fk_medicos
        FOREIGN KEY (id_medico) REFERENCES medicos(id)
			ON DELETE RESTRICT
			ON UPDATE CASCADE
);

CREATE TABLE prescricoes_medicamentos (
  id_prescricao INT NOT NULL,
  id_medicamento INT NOT NULL,
  dosagem VARCHAR(50) NOT NULL,
  forma_administracao VARCHAR(50) NOT NULL,
  CONSTRAINT prescricoes_medicamentos_fk_prescricoes
        FOREIGN KEY (id_prescricao) REFERENCES prescricoes(id)
				ON DELETE RESTRICT
                ON UPDATE CASCADE,
  CONSTRAINT prescricoes_medicamentos_fk_medicamentos
        FOREIGN KEY (id_medicamento) REFERENCES medicamentos(id)
				ON DELETE RESTRICT
                ON UPDATE CASCADE
);

INSERT INTO pacientes (nome, cpf, data_nascimento) VALUES 
('João Silva', '111.222.333-44', '1990-05-15'),
('Maria Santos', '555.666.777-88', '1985-02-20'),
('Lucas Souza', '999.888.777-66', '2000-09-03');

INSERT INTO medicos (nome, cpf, crm, especialidade) VALUES 
('Dr. José Santos', '444.555.666-77', '123456', 'Cardiologia'),
('Dra. Ana Oliveira', '888.777.666-55', '789012', 'Dermatologia'),
('Dr. Carlos Silva', '222.333.444-55', '345678', 'Ortopedia');

INSERT INTO consultas (id_medico, id_paciente, data_consulta) VALUES 
(1, 1, '2023-04-10 10:00:00'),
(2, 3, '2023-04-11 14:30:00'),
(3, 2, '2023-04-12 08:15:00');

INSERT INTO prontuarios (data_registro, descricao, id_paciente, id_medico) VALUES 
('2023-04-10 10:30:00', 'Paciente apresenta quadro de dor no peito e falta de ar.', 1, 1),
('2023-04-11 15:00:00', 'Paciente com manchas vermelhas na pele e coceira intensa.', 3, 2),
('2023-04-12 08:45:00', 'Paciente com fratura no tornozelo esquerdo.', 2, 3),
('2022-04-12 08:45:00', 'Teste.', 2, 3);

INSERT INTO exames (nome, data_solicitacao, id_prontuario) VALUES 
('Raio-X do Tornozelo', '2023-04-12', 3),
('Hemograma completo', '2023-04-11', 2),
('Eletrocardiograma', '2023-04-10', 1);

INSERT INTO medicamentos (nome, dosagem, forma_administracao) VALUES 
('Dipirona', '1 comprimido de 500mg', 'Oral'),
('Paracetamol', '1 comprimido de 750mg', 'Oral'),
('Amoxicilina', '1 comprimido de 500mg', 'Oral');

INSERT INTO prescricoes (data_prescricao, medicamento, id_medico, id_paciente) VALUES 
('2023-04-10 11:00:00', 'Dipirona', 1, 1),
('2023-04-11 15:30:00', 'Paracetamol', 2, 3),
('2023-04-12 09:00:00', 'Amoxicilina', 3, 2);

INSERT INTO prescricoes_medicamentos (id_prescricao, id_medicamento, dosagem, forma_administracao) VALUES 
  (1, 1, '1 comprimido ao dia', 'Via oral'),
  (1, 2, '2 gotas a cada 6 horas', 'Via nasal'),
  (1, 3, '1 comprimido de 12 em 12 horas', 'Via oral'),
  (2, 1, '2 comprimidos ao dia', 'Via oral'),
  (2, 2, '1 comprimido de 8 em 8 horas', 'Via oral'),
  (2, 3, '1 comprimido ao dia', 'Via oral'),
  (3, 1, '1 comprimido a cada 8 horas', 'Via oral'),
  (3, 2, '1 comprimido ao dia', 'Via oral'),
  (3, 3, '1 comprimido ao deitar', 'Via oral');


-- ConsultasAgendadas
CREATE VIEW view_consultas_agendadas AS
SELECT c.id, c.data_consulta, m.nome AS nome_medico, p.nome AS nome_paciente
FROM consultas c
JOIN medicos m 
	ON c.id_medico = m.id
INNER JOIN pacientes p 
	ON c.id_paciente = p.id
WHERE c.data_consulta > NOW();

select *
from view_consultas_agendadas;

-- ----------------------------------------------------------------------------------

-- ProntuariosRecentes
CREATE VIEW view_prontuarios_recentes AS
SELECT pr.id, pr.data_registro, pr.descricao, p.nome AS nome_paciente
FROM prontuarios pr
INNER JOIN pacientes p ON pr.id_paciente = p.id
WHERE pr.data_registro > DATE_SUB(NOW(), INTERVAL 30 DAY);

select *
from view_prontuarios_recentes;

-- ----------------------------------------------------------------------------------

--  view exibe as consultas realizadas por especialidade médica
CREATE VIEW view_consultas_por_especialidade AS
SELECT c.id AS id_consulta, 
       p.nome AS nome_paciente, 
       p.data_nascimento AS data_nascimento_paciente, 
       c.data_consulta, 
       m.nome AS nome_medico, 
       m.especialidade AS especialidade_medico
FROM consultas c
JOIN pacientes p ON c.id_paciente = p.id
JOIN medicos m ON c.id_medico = m.id
ORDER BY m.especialidade;

select *
from view_consultas_por_especialidade;

-- ----------------------------------------------------------------------------------

-- AgendarConsulta
DELIMITER $$
CREATE PROCEDURE agendar_consulta (
  IN data_consulta DATETIME,
  IN id_medico INT,
  IN id_paciente INT
)
BEGIN
  INSERT INTO consultas (data_consulta, id_medico, id_paciente)
  VALUES (data_consulta, id_medico, id_paciente);
END $$
DELIMITER ;

CALL agendar_consulta("2022-11-21", 2, 1);
DROP PROCEDURE agendar_consulta;

-- ----------------------------------------------------------------------------------

-- CadastrarPaciente
DELIMITER $$
CREATE PROCEDURE cadastrar_paciente (
  IN p_nome VARCHAR(100),
  IN p_cpf varchar(14),
  IN p_data_nascimento DATE
)
BEGIN
  INSERT INTO pacientes (nome, cpf, data_nascimento)
  VALUES (p_nome, p_cpf, p_data_nascimento);
END $$
DELIMITER ;

CALL cadastrar_paciente("arthur", "12391823", "2001-12-17");
DROP PROCEDURE cadastrar_paciente;

-- ----------------------------------------------------------------------------------

-- RegistrarProntuario
DELIMITER $$
CREATE PROCEDURE registrar_prontuario (
  IN p_descricao varchar(200),
  IN p_id_paciente INT,
  IN p_id_medico INT
)
BEGIN
  INSERT INTO prontuarios (data_registro, descricao, id_paciente, id_medico)
  VALUES (NOW(), p_descricao, p_id_paciente, p_id_medico);
END $$
DELIMITER ;

CALL registrar_prontuario("paciente com dificuldade para respirar ao realizar atividades fisicas", 3, 1);
DROP PROCEDURE registrar_prontuario;

-- ----------------------------------------------------------------------------------

DELIMITER $$
create procedure consulta_por_intervalo_informando( p_dataInicial datetime, p_dataFinal datetime)
begin	
		
		SELECT c.id as id_consulta, m.id as id_medico, p.id as id_paciente, c.data_consulta
		FROM consultas c
		INNER JOIN pacientes p ON c.id_paciente = p.id
        INNER JOIN medicos m on c.id_medico = m.id
		WHERE c.data_consulta >= p_dataInicial and c.data_consulta  <= p_dataFinal;
        
end $$
DELIMITER ;

call consulta_por_intervalo_informando('2022-10-01', '2023-04-11 15:00');
drop procedure consulta_por_intervalo_informando;


-- --------------------------------------------------------------------

DELIMITER $$
CREATE PROCEDURE consulta_por_medico(IN p_id_medico INT)
BEGIN
    SELECT c.id as id_consulta, m.id as id_medico, m.nome as nome_medico , p.id as id_paciente, c.data_consulta
    FROM consultas c
    INNER JOIN pacientes p ON c.id_paciente = p.id
    INNER JOIN medicos m ON c.id_medico = m.id
    WHERE m.id = p_id_medico;
END $$
DELIMITER ;

call consulta_por_medico(2);