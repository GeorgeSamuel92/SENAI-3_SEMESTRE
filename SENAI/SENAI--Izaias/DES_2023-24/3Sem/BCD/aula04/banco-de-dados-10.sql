CREATE DATABASE LOJA;
USE LOJA;

-- DDL Criação da Estrutura
CREATE TABLE TBL_CLIENTES (
    id INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(20) NOT NULL,
    sobrenome VARCHAR(45),
    sexo CHAR NOT NULL,
    peso DOUBLE,
    PRIMARY KEY (id)
);

CREATE TABLE TBL_TELEFONES (
    id INT NOT NULL AUTO_INCREMENT,
    id_cliente INT NOT NULL,
    telefone VARCHAR(15) UNIQUE,
    PRIMARY KEY (id),
    CONSTRAINT fk_clientes_telefones FOREIGN KEY(id_cliente) REFERENCES TBL_CLIENTES(id)
);

SHOW tables;

-- DML - Grupo de comandos responsáveis pela manipulação de dados em um banco de dados; isto geralmente implica em inserir, editar ou excluir linhas em tabelas SQL

-- Inserindo dados na tabela tbl_clientes
INSERT INTO `TBL_CLIENTES` (`NOME`,`SOBRENOME`,`SEXO`,`PESO`) VALUES ('IZAIAS', 'MAIA VIEIRA', 'M', 92.5);
INSERT INTO `TBL_CLIENTES` (`NOME`,`SOBRENOME`,`SEXO`,`PESO`) VALUES ('RODRIGO', 'SILVA', 'M', 80);
INSERT INTO `TBL_CLIENTES` (`NOME`,`SOBRENOME`,`SEXO`,`PESO`) VALUES ('JOSÉ', 'CARLOS JUSTINO', 'M', 65);
INSERT INTO TBL_CLIENTES (NOME,SOBRENOME,SEXO,PESO) VALUES ('ANA', 'CAROLINA CAPINO', 'F', 56.5);
INSERT INTO TBL_CLIENTES (NOME,SOBRENOME,SEXO,PESO) VALUES ('JOÃO', 'PEDRO SILVA', 'M', 105.5);

INSERT INTO TBL_TELEFONES(ID_CLIENTE, TELEFONE) VALUES (1, '19986536254');
INSERT INTO TBL_TELEFONES(ID_CLIENTE, TELEFONE) VALUES (4, '19555555555');
INSERT INTO TBL_TELEFONES(ID_CLIENTE, TELEFONE) VALUES (5, '19222222222');
INSERT INTO TBL_TELEFONES(ID_CLIENTE, TELEFONE) VALUES (2, '19111111111');
INSERT INTO TBL_TELEFONES(ID_CLIENTE, TELEFONE) VALUES (2, '19444444444');
INSERT INTO TBL_TELEFONES(ID_CLIENTE, TELEFONE) VALUES (1, '19333333333');
INSERT INTO TBL_TELEFONES(ID_CLIENTE, TELEFONE) VALUES (3, '19855548698');
INSERT INTO TBL_TELEFONES(ID_CLIENTE, TELEFONE) VALUES (1, '19888888888');
INSERT INTO TBL_TELEFONES(ID_CLIENTE, TELEFONE) VALUES (5, '19999999999');

/* ALIAS DE COLUNAS */
SELECT NOME, SEXO FROM TBL_CLIENTES;
SELECT NOME AS CLIENTE, SEXO FROM TBL_CLIENTES;

/* SELECT DE TODOS OS REGISTROS DAS TABELAS CLIENTES E TELEFONEStbl_telefones*/
SELECT * FROM TBL_CLIENTES;
SELECT * FROM TBL_TELEFONES;

/* SELECT UTILIZANDO O LIKE */
SELECT NOME, SEXO FROM TBL_CLIENTES
WHERE NOME LIKE 'IZAIAS';

/* SELECT UTILIZANDO O CARACTER CORINGA % -> QUALQUER COISA */
SELECT 
    NOME, SEXO
FROM
    TBL_CLIENTES
WHERE
    NOME LIKE '%O%';

/* SELECT UTILIZANDO O WHERE E LIKE COM CARACTER CORINGA */
SELECT 
    NOME, SEXO
FROM
    TBL_CLIENTES
WHERE
    SEXO = 'F' AND NOME LIKE '%A';    
    
/* SELECT AGRUPANDO POR SEXO E CONTANDO A QUANTIDADE DE OCORRÊNCIAS POR AGRUPAMENTO */
SELECT SEXO, COUNT(*) AS TOTAL
FROM TBL_CLIENTES
GROUP BY SEXO;

/* AND TRAZ TODO REGISTRO QUE ATENDA OBRIGATORIAMENTE AS DUAS CONDIÇÕES*/
SELECT 
    *
FROM
    TBL_CLIENTES
WHERE
    NOME = 'IZAIAS' AND PESO = 90.5;

/*-- Quando estamos trabalhando com OR e a segunda condicao é opcional colocamos na primeira condicao quem tem mais chances de uma saida
verdadeira, pois a segunda condicao nao será checada nesse caso.*/
SELECT 
    *
FROM
    TBL_CLIENTES
WHERE
    SEXO = 'M' OR PESO = 90.0;

/* SELECT DE DUAS TABELAS COM INNER JOIN */
SELECT *
FROM TBL_CLIENTES AS CLI
INNER JOIN TBL_TELEFONES AS TEL
ON CLI.ID=TEL.ID_CLIENTE;

/* SELECT DE DUAS TABELAS COM INNER JOIN SELECIONANDO OS CAMPOS A SEREM MOSTRADOS */
SELECT CLI.NOME, CLI.SOBRENOME, CLI.SEXO, CLI.PESO, TEL.TELEFONE
FROM TBL_CLIENTES AS CLI
INNER JOIN TBL_TELEFONES AS TEL
ON CLI.ID=TEL.ID_CLIENTE;


/* SELECT DE DUAS TABELAS CONCATENANDO NOME E SOBRENOME */
SELECT CONCAT(CLI.NOME, ' ',CLI.SOBRENOME) AS NOME_COMPLETO, 
CLI.SEXO, CLI.PESO, TEL.TELEFONE
FROM TBL_CLIENTES AS CLI
INNER JOIN TBL_TELEFONES AS TEL
ON CLI.ID=TEL.ID_CLIENTE;

/* SELECT DE DUAS TABELAS CONCATENANDO NOME E SOBRENOME 
EM UMA ÚNICA COLUNA E TELEFONES  EM UMA ÚNICA COLUNA*/
SELECT CONCAT(CLI.NOME, ' ',CLI.SOBRENOME) AS NOME_COMPLETO, 
CLI.SEXO, CLI.PESO, 
GROUP_CONCAT(TEL.TELEFONE) AS TELEFONES
FROM TBL_CLIENTES AS CLI
INNER JOIN TBL_TELEFONES AS TEL
ON CLI.ID=TEL.ID_CLIENTE
GROUP BY NOME, SOBRENOME, SEXO, PESO;

/* SELECT DE DUAS TABELAS CONCATENANDO NOME E SOBRENOME 
EM UMA ÚNICA COLUNA E TELEFONES  EM UMA ÚNICA COLUNA, INCLUINDO WHERE*/
SELECT CLI.ID,
CONCAT(CLI.NOME, ' ',CLI.SOBRENOME) AS NOME_COMPLETO, 
CLI.SEXO, CLI.PESO, 
GROUP_CONCAT(TEL.TELEFONE) AS TELEFONES
FROM TBL_CLIENTES AS CLI
INNER JOIN TBL_TELEFONES AS TEL
ON CLI.ID=TEL.ID_CLIENTE
WHERE CLI.ID IN (2,5)
GROUP BY ID, NOME, SOBRENOME, SEXO, PESO;

/* SELECT UTILIZANDO O LIKE */
SELECT NOME, SEXO FROM TBL_CLIENTES
WHERE NOME LIKE 'IZAIAS';

/* SELECT UTILIZANDO O CARACTER CORINGA % -> QUALQUER COISA */
SELECT 
    NOME, SEXO
FROM
    TBL_CLIENTES
WHERE
    NOME LIKE '%O%';

/* SELECT UTILIZANDO O WHERE E LIKE COM CARACTER CORINGA */
SELECT 
    NOME, SEXO
FROM
    TBL_CLIENTES
WHERE
    SEXO = 'F' AND NOME LIKE '%A';    
    
/* SELECT AGRUPANDO POR SEXO E CONTANDO A QUANTIDADE DE OCORRÊNCIAS POR AGRUPAMENTO */
SELECT SEXO, COUNT(*) AS TOTAL
FROM TBL_CLIENTES
GROUP BY SEXO;

/* AND TRAZ TODO REGISTRO QUE ATENDA OBRIGATORIAMENTE AS DUAS CONDIÇÕES*/
SELECT 
    *
FROM
    TBL_CLIENTES
WHERE
    NOME = 'IZAIAS' AND PESO = 90.5;

/*-- Quando estamos trabalhando com OR e a segunda condicao é opcional colocamos na primeira condicao quem tem mais chances de uma saida
verdadeira, pois a segunda condicao nao será checada nesse caso.*/
SELECT 
    *
FROM
    TBL_CLIENTES
WHERE
    SEXO = 'M' OR PESO = 90.0;

/* Update é uma instrução da linguagem SQL que altera os dados de um ou mais registros em uma tabela. 
Nem todas as linhas precisam ser atualizadas, um subconjunto pode ser escolhido utilizando uma condição*/

/* UPDATE - ATUALIZANDO O CAMPO PESO DA TABELA CLIENTES*/
UPDATE TBL_CLIENTES 
SET 
    PESO = 90.0
WHERE
    ID = 2;

/* UPDATE - ATUALIZANDO O CAMPO ID_CLIENTE DA TABELA TELEFONES*/
UPDATE TBL_TELEFONES 
SET 
    ID_CLIENTE = 5
WHERE
    ID = 2;
    
/* Na linguagem de consulta estruturada de banco de dados (SQL), a instrução DELETE remove um ou mais registros de uma tabela. 
Um subconjunto pode ser definido para exclusão usando uma condição, caso contrário, todos os registros serão removidos.*/
DELETE FROM TBL_CLIENTES 
WHERE
    ID = 2
    AND PESO = 90.5;

/* ALTERAR O NOME DE UMA COLUNA COM CHANGE */
ALTER TABLE TBL_CLIENTES
CHANGE opcao sexo CHAR NOT NULL;

/* */


