
CREATE TABLE tbl_clientes(
	id INT NOT NULL AUTO_INCREMENT,
	nome VARCHAR(45) NOT NULL,
	telefone VARCHAR(45) NOT NULL,
	endereco VARCHAR(100) NOT NULL,
	PRIMARY KEY (id)
  );
  
  insert into tbl_clientes(nome, telefone, endereco)
  values ('Paulo', '11998524552', 'rua Putão, feds, apartamento');
  
  delete from tbl_clientes where ID=8;  
  
  alter table tbl_clientes
  add  column sobrenome varchar(45)
  after nome;
  
  alter table tbl_clientes
  drop column sobrenome;

  select * from loja.tbl_clientes;
  select * from tbl_telefones;
  
  create table if not exists tbl_telefones(
  id int not null auto_increment,
  id_cliente int not null,
  numero varchar (11) not null,
  primary key (id),
  constraint fk_cliente_telefones foreign key(id_cliente) references tbl_clientes(id)
  );
  
  --
  insert into tbl_clientes(nome, sobrenome, sexo, peso, data_nasc)
  values('Jurema', 'de Souza Castro', 'F', 80, '2007-06-15');
  --
  
  alter table tbl_clientes
  modify peso double;
  
  delete from tbl_clientes where id=7;
  
  insert into tbl_telefones(id_cliente, numero) values (10, '11987654321');
  insert into tbl_telefones(id_cliente, numero) values (11, '11876543210');
insert into tbl_telefones(id_cliente, numero) values (12, '11765432109');
insert into tbl_telefones(id_cliente, numero) values (13, '11654321098');
insert into tbl_telefones(id_cliente, numero) values (14, '11543210987');
insert into tbl_telefones(id_cliente, numero) values (15, '11432109876');

insert into tbl_telefones(id_cliente, numero) values (10, '11210987654');
insert into tbl_telefones(id_cliente, numero) values (11, '11210987654');
insert into tbl_telefones(id_cliente, numero) values (12, '11109876543');
insert into tbl_telefones(id_cliente, numero) values (13, '12098765432');
insert into tbl_telefones(id_cliente, numero) values (14, '12987654321');

select nome, sexo from tbl_clientes;
  select nome as cliente, sexo from tbl_clientes;
  
  select *
  from tbl_clientes as cli
  inner join tbl_telefones as tel
  on cli.id=tel.id_cliente;
  
  select cli.nome, cli.sobrenome, cli.sexo, cli.peso, tel.numero
  from tbl_clientes as cli
  inner join tbl_telefones as tel
  on cli.id=tel.id_cliente;
  
  /* select de duas tabelas concatenado nome e sobrenome */
   select concat(cli.nome,' ', cli.sobrenome) as nome_completo, cli.sexo, cli.peso, tel.numero
  from tbl_clientes as cli
  inner join tbl_telefones as tel
  on cli.id=tel.id_cliente;
  
  /* select de duas tabelas concatenado nome e sobrenome em uma unica coluna e telefone em uma unica coluna*/
    select concat(cli.nome,' ', cli.sobrenome) as nome_completo,
    cli.sexo, cli.peso,
    group_concat(tel.numero) as telefones
	from tbl_clientes as cli
	inner join tbl_telefones as tel
	on cli.id=tel.id_cliente
	group by nome, sobrenome, sexo, peso;
    
    /* select de duas tabelas concatenado nome e sobrenome em uma unica coluna e telefone em uma unica coluna, incluindo where*/
    select cli.id,
    concat(cli.nome,' ', cli.sobrenome) as nome_completo,
    cli.sexo, cli.peso,
    group_concat(tel.numero) as telefones
	from tbl_clientes as cli
	inner join tbl_telefones as tel
	on cli.id=tel.id_cliente
    where cli.id in (9,10)
	group by id,nome, sobrenome, sexo, peso;
    
    /*update*//*formula*/
    update tbl_clientes
    set
		nome_campo='novovalor'
    where
		id_tabela=valor_do_id;
        
        /*exemplo*/
    update tbl_clientes
    set
		peso='90.5'
    where
		id=9;
        
        update tbl_telefones
    set
		id_cliente='10'
    where
		id=3;
    
    /* ultilizando like, faz uma procura no banco de dados*/
    select nome, sexo from tbl_clientes
    where nome like 'p%';
    
    drop database loja;
    
    