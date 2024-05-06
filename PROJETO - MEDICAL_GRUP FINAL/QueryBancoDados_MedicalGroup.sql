CREATE DATABASE clinica;

USE clinica;

CREATE TABLE IF NOT EXISTS tbl_pessoas (
id INT NOT NULL AUTO_INCREMENT,
nome VARCHAR(50) NOT NULL,
data_nasc DATE NOT NULL,
cpf VARCHAR(11) NOT NULL,
email VARCHAR(125),
genero VARCHAR(30),
data_cad TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
PRIMARY KEY (id)

);

CREATE TABLE IF NOT EXISTS tbl_funcionarios (
	id INT NOT NULL AUTO_INCREMENT,
    id_pessoas INT NOT NULL,
    data_admissao DATE NOT NULL,
    CRM VARCHAR(12),
	PRIMARY KEY (id),
    CONSTRAINT fk_tblfuncionarios__tbl_pessoas FOREIGN KEY (id_pessoas)
		REFERENCES tbl_pessoas (id)
);

CREATE TABLE IF NOT EXISTS tbl_pacientes (
	id INT NOT NULL AUTO_INCREMENT,
    id_pessoas INT NOT NULL,
	PRIMARY KEY (id),
    CONSTRAINT fk_tbl_pessoas__tbl_paciente FOREIGN KEY (id_pessoas)
		REFERENCES tbl_pessoas (id)
);


CREATE TABLE IF NOT EXISTS tbl_consulta (
	id INT NOT NULL AUTO_INCREMENT,
	PRIMARY KEY (id),
    data_cons DATE,
    hora_cons TIME,
    id_paciente INT NOT NULL,
    id_medico INT NOT NULL,
    CONSTRAINT fk_tbl_consulta__tbl_paciente FOREIGN KEY (id_paciente)
		REFERENCES tbl_pacientes (id),
	CONSTRAINT fk_tbl_consulta__tbl_funcionarios FOREIGN KEY (id_medico)
		REFERENCES tbl_funcionarios (id)
);

 /* id_descrito INT NOT NULL,
 ...
 CONSTRAINT fk_tabela_atual__tabela_origem FOREING id_descrito 
        REFERENCES tabela_origem (id)
*/;

CREATE TABLE IF NOT EXISTS tbl_especialidades (
	id INT NOT NULL AUTO_INCREMENT,
	PRIMARY KEY (id),
    descr_espec VARCHAR(45) NOT NULL
);

CREATE TABLE IF NOT EXISTS tbl_especialidade_HAS_tbl_funcionario (
    tbl_especialidade_id INT NOT NULL,
    tbl_funcionario_id INT NOT NULL,
    CONSTRAINT fk_tbl_especialidade_tbl_funcionarios FOREIGN KEY (tbl_especialidade_id)
		REFERENCES tbl_especialidades (id),
	CONSTRAINT fk_tbl_funcionarios__tbl_especialidades FOREIGN KEY (tbl_funcionario_id)
		REFERENCES tbl_funcionarios (id)
);

CREATE TABLE IF NOT EXISTS tbl_prontuario (
	id INT NOT NULL AUTO_INCREMENT,
	PRIMARY KEY (id),
    diagnostico VARCHAR(1000),
    medicação VARCHAR(300),
    tbl_especialidade INT NOT NULL,
    tbl_consulta INT NOT NULL,
    CONSTRAINT fk_tbl_prontuario__tbl_especialdiade FOREIGN KEY (tbl_especialidade)
		REFERENCES tbl_especialidades (id),
	CONSTRAINT fk_tbl_prontuario__tbl_consulta FOREIGN KEY (tbl_consulta)
		REFERENCES tbl_consulta (id)
);

CREATE TABLE IF NOT EXISTS tbl_login (
	id INT NOT NULL AUTO_INCREMENT,
	PRIMARY KEY (id),
    login VARCHAR(125),
    medicação VARCHAR(500),
    tbl_pessoa_id INT NOT NULL,
    CONSTRAINT fk_tbl_login__tbl_pessoas FOREIGN KEY (tbl_pessoa_id)
		REFERENCES tbl_pessoas (id)
);

CREATE TABLE IF NOT EXISTS tbl_perfil (
	id INT NOT NULL AUTO_INCREMENT,
	PRIMARY KEY (id),
    dtipo VARCHAR(125),
    tbl_login_id INT NOT NULL,
    CONSTRAINT fk_tbl_perfil__tbl_login FOREIGN KEY (tbl_login_id)
		REFERENCES tbl_login (id)
);

CREATE TABLE IF NOT EXISTS tbl_telefone (
	id INT NOT NULL AUTO_INCREMENT,
	PRIMARY KEY (id),
    numero VARCHAR(20)
);

CREATE TABLE IF NOT EXISTS tbl_telefone_HAS_tbl_pessoas (
    tbl_telefone_id INT NOT NULL,
    tbl_pessoa_id INT NOT NULL,
    CONSTRAINT fk_tbl_telefone__tbl_pessoas  FOREIGN KEY (tbl_pessoa_id)
		REFERENCES tbl_pessoas (id),
	CONSTRAINT fk_tbl_pessoas__tbl_telefone FOREIGN KEY (tbl_telefone_id)
		REFERENCES tbl_telefone (id)
);

CREATE TABLE IF NOT EXISTS tbl_endereco (
	id INT NOT NULL AUTO_INCREMENT,
	PRIMARY KEY (id),
   logradouro VARCHAR(100) NOT NULL,
   bairro VARCHAR(50) NOT NULL,
   estado VARCHAR(50) NOT NULL,
   numero VARCHAR(45) NOT NULL,
   Complemento VARCHAR(50),
   CEP VARCHAR(45)
);

ALTER TABLE tbl_pessoas ADD COLUMN
tbl_endereco_id INT NOT NULL;

ALTER TABLE tbl_pessoas ADD
    CONSTRAINT fk_tbl_endereco_tbl_pessoas FOREIGN KEY (tbl_endereco_id)
    REFERENCES tbl_endereco (id);

/*Cadastro de informaçoes*/
INSERT INTO tbl_endereco (logradouro, bairro, estado, numero, complemento, cep) VALUES 
('Rua das Flores', 'Centro', 'SP', '100', 'Apto 101', '12345678'),
('Avenida Brasil', 'Jardim América', 'RJ', '500', 'Casa 2', '87654321'),
('Rua dos Girassóis', 'Vila Nova', 'MG', '300', 'Bloco B', '45678901'),
('Rua das Palmeiras', 'Morumbi', 'SP', '700', 'Apto 302', '23456789'),
('Avenida Paulista', 'Bela Vista', 'SP', '1000', 'Casa 1', '34567890'),
('Rua das Margaridas', 'Copacabana', 'RJ', '200', 'Casa 3', '98765432'),
('Avenida Amazonas', 'Barra da Tijuca', 'RJ', '800', 'Bloco C', '56789012'),
('Rua das Acácias', 'Centro', 'SP', '400', 'Casa 4', '65432109'),
('Avenida das Flores', 'Jardim Botânico', 'DF', '600', 'Apartamento 501', '89012345'),
('Rua das Violetas', 'Jardim São Paulo', 'PE', '200', 'Casa 5', '01234567');

-- Cadastro de pessoa com restrição de chave estrangeira
INSERT INTO tbl_pessoas (nome, cpf, data_nasc, genero, email, tbl_endereco_id) 
VALUES 
('João Silva', '12345678900', '1990-05-15', 'Masculino', 'joao@example.com', 1),
('Maria Souza', '98765432100', '1985-10-25', 'Feminino', 'maria@example.com', 2),
('Carlos Oliveira', '45678912300', '1978-08-12', 'Masculino', 'carlos@example.com', 3),
('Ana Santos', '78912345600', '1995-03-08', 'Feminino', 'ana@example.com', 4),
('Pedro Costa', '32165498700', '1982-12-30', 'Masculino', 'pedro@example.com', 5),
('Laura Lima', '65432198700', '1998-07-20', 'Feminino', 'laura@example.com', 6),
('Rafaela Fernandes', '23456789000', '1989-06-18', 'Feminino', 'rafaela@example.com', 7),
('Gabriel Oliveira', '87654321000', '1976-09-05', 'Masculino', 'gabriel@example.com', 8),
('Fernando Pereira', '54321087600', '1993-02-28', 'Masculino', 'fernando@example.com', 9),
('Juliana Almeida', '21098765400', '1987-11-14', 'Feminino', 'juliana@example.com', 10);


-- Cadastro de numeros de telefone --

INSERT INTO tbl_telefone (numero) 
VALUES 
('(11) 98765-4321'), 
('(11) 98765-4322'), 
('(11) 98765-4323'), 
('(11) 98765-4324'), 
('(11) 98765-4325'), 
('(11) 98765-4326'), 
('(11) 98765-4327'), 
('(11) 98765-4328'), 
('(11) 98765-4329'), 
('(11) 98765-4330'),

('(11) 98765-4321'), 
('(22) 12345-6789'), 
('(33) 45678-9012'),
('(44) 98765-4321'), 
('(55) 12345-6789'), 
('(66) 45678-9012'),
('(77) 98765-4321'), 
('(88) 12345-6789'), 
('(99) 45678-9012'),
('(10) 98765-4321');

-- associando fk em bl_telefone_has_tbl_pessoas
insert into tbl_telefone_has_tbl_pessoas (tbl_telefone_id, tbl_pessoa_id) values
-- telefone, pessoa
(1, 1), 
(2, 1),

(3, 2),
(4, 2),

(5, 3),
(6, 3),

(7, 4),
(8, 4),

(9, 5),
(10, 5),

(10, 6),
(21, 6),

(23, 7),
(24, 7),

(25, 8),
(26, 8),

(27, 9),
(28, 9),

(29, 10),
(30, 10);

INSERT INTO tbl_especialidades (descr_espec) VALUES
('Cardiologia'),
('Dermatologia'),
('Ginecologia'),
('Ortopedia'),
('Pediatria'),

INSERT INTO tbl_funcionarios (id_pessoas, data_admissao, CRM) VALUES
(2, '2024-02-20', '789012'),
(4, '2024-05-12', '567890'),
(5, '2024-06-25', '234567'),
(6, '2024-07-08', '890123'),
(7, '2024-08-14', '456789');

insert into tbl_especialidade_has_tbl_funcionario (tbl_especialidade_id, tbl_funcionario_id) values
(1, 2), -- especialidade, tbl]-funcionario
(2, 5),
(3, 6),
(4, 4),
(5, 7);

INSERT INTO tbl_pacientes ( id_pessoas) values
(1),
(3),
(4),
(8),
(9),
(10),
(7),
(5);

INSERT INTO tbl_consulta ( data_cons, hora_cons, id_paciente, id_medico ) value
('2024-04-15', '08:00', 1, 1),
('2024-04-15', '09:00', 3, 2),
('2024-04-16', '10:00', 4, 3),
('2024-04-16', '11:00', 8, 4),
('2024-04-17', '12:00', 10, 5),
('2024-04-17', '13:00', 7, 6),
('2024-04-18', '14:00', 1, 7),
('2024-04-18', '15:00', 9, 8),
('2024-04-19', '16:00', 3, 9),
('2024-04-19', '17:00', 4, 10);

INSERT INTO tbl_prontuario ( diagnostico, medicação, tbl_especialidade, tbl_consulta) VALUES
('')




