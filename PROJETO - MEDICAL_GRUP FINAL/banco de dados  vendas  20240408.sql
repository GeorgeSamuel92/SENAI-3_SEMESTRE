CREATE DATABASE vendas;

USE vendas;

CREATE TABLE IF NOT EXISTS tbl_produtos (
id INT NOT NULL AUTO_INCREMENT,
nome_prod VARCHAR(50) NOT NULL,
unidade VARCHAR(20) NOT NULL,
data_cad TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS tbl_valor_produtos (
	id INT NOT NULL AUTO_INCREMENT,
    id_prod INT NOT NULL,
    valor DECIMAL (10, 2) NOT NULL,
    data_cad TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (id),
    CONSTRAINT fk_tbl_produtos_tbl_valor_produtos FOREIGN KEY (id_prod)
		REFERENCES tbl_produtos (id)

);

INSERT INTO tbl_produtos (nome_prod, unidade) VALUES
('Produto A', 'kilograma'),
('Produto B', 'unidade'),
('Produto C', 'litro'),
('Produto D', 'kilograma');

INSERT INTO IF NOT EXISTS tbl_produtos(nome_prod, unidade) VALUES
('Produto E', 'unidade');

INSERT INTO tbl_valor_produtos (id_prod, valor) VALUES
(1, 10.50),
(2, 15.75),
(3, 20.00);

INSERT INTO tbl_valor_produtos (id_prod, valor) VALUES
(1, 12.50),
(2, 13.00),
(3, 23.00),
(4, 16.00);

SELECT 
*
FROM
	tbl_produtos p
INNER JOIN 
	tbl_valor_produtos vp ON p.id = vp.id_prod;

SELECT 
	p.nome_prod,
    vp.valor,
    p.unidade,
    vp.data_cad
FROM
	tbl_produtos p
INNER JOIN 
	tbl_valor_produtos vp ON p.id = vp.id_prod;

SELECT 
	*
FROM
	tbl_produtos p
LEFT OUTER JOIN 
	tbl_valor_produtos vp ON p.id = vp.id_prod;
    
    /*2024 04 08*/
    
SELECT 
	p.nome_prod,
    vp.valor,
    p.unidade,
    vp.data_cad
FROM
	tbl_produtos p
RIGHT OUTER JOIN 
	tbl_valor_produtos vp ON p.id = vp.id_prod;  
    
SELECT 
	p.nome_prod,
    vp.valor,
    p.unidade,
    vp.data_cad
FROM
	tbl_produtos p
CROSS JOIN
	tbl_valor_produtos vp ON p.id = vp.id_prod;

SELECT *
FROM tbl_valor_produtos
WHERE valor NOT IN (12.5, 20);

SELECT *
FROM tbl_valor_produtos
WHERE valor NOT IN (20);

SELECT *
FROM tbl_produtos
WHERE id IN (SELECT id_prod FROM tbl_valor_produtos WHERE valor < 20 );

SELECT *
FROM tbl_produtos
WHERE id NOT IN (SELECT id_prod FROM tbl_valor_produtos WHERE valor < 16 );

SELECT *
FROM tbl_produtos p
WHERE p.id > ALL ( SELECT id_prod FROM tbl_valor_produtos WHERE valor < 18);

SELECT *
FROM tbl_produtos p
WHERE p.id = ANY (SELECT id_prod FROM tbl_valor_produtos WHERE valor < 16);

SELECT nome_prod
FROM tbl_produtos p
WHERE EXISTS (
	SELECT *
    FROM tbl_valor_produtos vp
    WHERE vp.id_prod = p.id AND vp.valor < 20
);

SELECT
	p.nome_prod AS produto,
    vp.valor AS valor_unitario
FROM
	tbl_produtos p
JOIN
	tbl_valor_produtos vp ON p.id = vp.id_prod
WHERE
	p.nome_prod = 'Produto A'
ORDER BY
	vp.data_cad DESC
LIMIT 1;

SELECt 
	p.nome_prod AS produto,
    vp.valor AS valor_unitario,
    vp.valor * 10 AS preco_total
FROM
	tbl_produtos p
JOIN
	tbl_valor_produtos vp ON p.id = vp.id_prod
WHERE
	p.nome_prod = 'Produto A'
ORDER BY
	vp.data_cad DESC
LIMIT 1;
/*2024 04 10*/

USE vendas;

SELECT 100 + 50 AS RESULT;

SELECT 100 + 8 - 20 AS RESULT;

SELECT 8 -5 AS RESULT;

SELECT 2 * 5 AS RESULT;

SELECT (2 * 5 + 10 ) RESULT;

SELECT (2 * 5 / 10 ) RESULT;

SELECT (( 2 * 5) + 10 / 10) RESULT;

SELECT ROUND( 2 * 5 / 13 ) RESULT;

UPDATE tbl_valor_produtos AS vp
SET 
	vp.valor = vp.valor * 1.05
WHERE ID = 5;


SELECT DATE_SUB(NOW(), INTERVAL 2 DAY);
SELECT DATE_SUB(NOW(), INTERVAL 2 HOUR);
SELECT DATE_SUB(NOW(), INTERVAL 2 MINUTE);
SELECT DATE_SUB(NOW(), INTERVAL 120 SECOND);
SELECT DATE_SUB('2024-04-10', INTERVAL 2 DAY);

SELECT DATE_ADD(NOW(), INTERVAL 2 DAY);

SELECT CURDATE();

SELECT CURTIME();

SELECT COUNT(*) AS qtd_produtos FROM vendas.tbl_produtos;

SELECT SUM(valor) AS VALOR FROM vendas.tbl_valor_produtos;

SELECT AVG(valor) AS VALOR FROM vendas.tbl_valor_produtos;

select max(valor) as valor from vendas.tbl_valor_produtos;

