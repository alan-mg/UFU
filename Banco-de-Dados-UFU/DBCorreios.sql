***CRIAR A TABELA DE DADOS PARA IMPORTAR 

CREATE TABLE `enderecos` (
							  `cep` varchar(255) NOT NULL,
							  `estado` varchar(255) NOT NULL,
							  `cidade` varchar(255) NOT NULL,
							  `bairro` varchar(255) NOT NULL,
							  `rua` varchar(255) NOT NULL,
							  `id` int(15) NOT NULL auto_increment,
							   PRIMARY KEY  (`id`)
							) engine=InnoDB default charset=utf8 collate utf8_unicode_ci;

***IMPORTAR ARQUIVOS NO MYSQL PELO SHELL UBUNTU

LOAD DATA INFILE 'DBCorreios.csv' 
INTO TABLE enderecos
CHARACTER SET utf8
FIELDS TERMINATED BY ';' 
LINES TERMINATED BY '\n'
(cep,estado,cidade,bairro,rua);

***CRIAR A TABELA DE DADOS



CREATE TABLE `table_endereco` (
							  `id_endereco` int(15) NOT NULL auto_increment,
							  `id_estado` int(15) NOT NULL UNIQUE,
							  `id_cidade` int(15) NOT NULL UNIQUE,
							  `id_bairro` int(15) NOT NULL UNIQUE,
							  `id_rua` int(15) NOT NULL UNIQUE,
							   PRIMARY KEY  (`id_endereco`)
							) engine=InnoDB default charset=utf8 collate utf8_unicode_ci;


CREATE TABLE `table_estado` (
	                          `id_estado` int(15) NOT NULL,
							  `estado` varchar(255) NOT NULL,
							  `id_cidade` int(15) NOT NULL,
                               PRIMARY KEY  (`id_estado`)
							) engine=InnoDB default charset=utf8 collate utf8_unicode_ci;

CREATE TABLE `table_cidade` (
	                          `id_cidade` int(15) NOT NULL,
							  `cidade` varchar(255) NOT NULL,
							  `id_bairro` int(15) NOT NULL,
                               PRIMARY KEY  (`id_cidade`)
							) engine=InnoDB default charset=utf8 collate utf8_unicode_ci;

CREATE TABLE `table_bairro` (
	                          `id_bairro` int(15) NOT NULL,
							  `bairro` varchar(255) NOT NULL,
							  `id_rua` int(15) NOT NULL,
                               PRIMARY KEY  (`id_bairro`)
							) engine=InnoDB default charset=utf8 collate utf8_unicode_ci;

CREATE TABLE `table_rua` (
	                          `id_rua` int(15) NOT NULL,
							  `rua` varchar(255) NOT NULL,
                               PRIMARY KEY  (`id_rua`)
							) engine=InnoDB default charset=utf8 collate utf8_unicode_ci;

***CHAVES PRIMARIAS E ESTRANGEIRAS

*** TABELA DE CEP E ESTADO
ALTER TABLE `table_cep` ADD CONSTRAINT `fk_cep_estado` FOREIGN KEY ( `id_estado` ) REFERENCES `table_estado` ( `id_estado` );

*** TABELA DE CIDADE
ALTER TABLE `table_cep` ADD CONSTRAINT `fk_cep_cidade` FOREIGN KEY ( `id_cidade` ) REFERENCES `table_cidade` ( `id_cidade` );
ALTER TABLE `table_estado` ADD CONSTRAINT `fk_estado_cidade` FOREIGN KEY ( `id_cidade` ) REFERENCES `table_cidade` ( `id_cidade` );

*** TABELA DE BAIRRO
ALTER TABLE `table_cep` ADD CONSTRAINT `fk_cep_bairro` FOREIGN KEY ( `id_bairro` ) REFERENCES `table_bairro` ( `id_bairro` );
ALTER TABLE `table_cidade` ADD CONSTRAINT `fk_cidade_bairro` FOREIGN KEY ( `id_bairro` ) REFERENCES `table_bairro` ( `id_bairro` );

*** TABELA DE RUA
ALTER TABLE `table_cep` ADD CONSTRAINT `fk_cep_rua` FOREIGN KEY ( `id_rua` ) REFERENCES `table_rua` ( `id_rua` );
ALTER TABLE `table_bairro` ADD CONSTRAINT `fk_bairro_rua` FOREIGN KEY ( `id_rua` ) REFERENCES `table_rua` ( `id_rua` );


***TRANSFERINDO O DADO DA TABELA GENERICA PARA AS TABELAS DE FATO

INSERT INTO table_rua (id_rua, rua)
SELECT id, rua from enderecos;
INSERT INTO table_bairro (id_bairro, bairro, id_rua)
SELECT id, bairro, id from enderecos;
INSERT INTO table_cidade (id_cidade, cidade, id_bairro)
SELECT id, cidade, id from enderecos;
INSERT INTO table_estado (id_estado, estado, id_cidade)
SELECT id, estado, id from enderecos;
INSERT INTO table_cep (cep, id_estado, id_cidade, id_bairro, id_rua)
SELECT cep, id, id, id, id from enderecos;


***Uma view que retorne todas as ruas do estado de São Paulo
SELECT rua
FROM table_estado
INNER JOIN table_cidade on table_cidade.id_cidade = table_estado.id_cidade
INNER JOIN table_bairro on table_bairro.id_bairro = table_cidade.id_bairro
INNER JOIN table_rua on table_rua.id_rua = table_bairro.id_rua
WHERE estado = 'SP'

***Uma view que retorne todas as cidades do estado de Minas Gerais (FUNÇÃO DISTINCT PARA REMOVER CIDADES DUPLICADAS)
SELECT DISTINCT cidade
FROM table_estado
INNER JOIN table_cidade on table_cidade.id_cidade = table_estado.id_cidade
WHERE estado = 'MG'

***View que retorna todos os endereços de forma completa (estado, cidade, bairro, rua) e os agrupa pelo cep. (É necessário desativar ONLY_FULL_GROUP_BY em sql mode)
SELECT cep, estado, cidade, bairro, rua
FROM table_cep
INNER JOIN table_estado on table_estado.id_estado = table_cep.id_estado
INNER JOIN table_cidade on table_cidade.id_cidade = table_cep.id_cidade
INNER JOIN table_bairro on table_bairro.id_bairro = table_cep.id_bairro
INNER JOIN table_rua on table_rua.id_rua = table_cep.id_rua
GROUP BY cep