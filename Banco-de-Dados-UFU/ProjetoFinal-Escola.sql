CREATE TABLE `table_administrador`(
	id_administrador int(15) NOT NULL,
	id_pessoa int(15) NOT NULL,
    PRIMARY KEY (`id_administrador`)
) engine=InnoDB default charset=utf8 collate utf8_unicode_ci;


CREATE TABLE `table_estudante`(
	id_estudante int(15) NOT NULL,
	id_pessoa int(15) NOT NULL,
	id_escola int(15) NOT NULL,
    serie_atual varchar(255) NOT NULL,
    PRIMARY KEY (`id_estudante`)
) engine=InnoDB default charset=utf8 collate utf8_unicode_ci;

CREATE TABLE `table_professor`(
	id_professor int(15) NOT NULL,
	id_pessoa int(15) NOT NULL,
    PRIMARY KEY (`id_professor`)
) engine=InnoDB default charset=utf8 collate utf8_unicode_ci;

CREATE TABLE `table_professor_escola`(
	id_professor int(15) NOT NULL,
	id_escola int(15) NOT NULL,
    PRIMARY KEY (`id_professor`, `id_escola`)
) engine=InnoDB default charset=utf8 collate utf8_unicode_ci;

CREATE TABLE `table_pessoa`(
	id_pessoa int(15) NOT NULL,
	nome varchar(255) NOT NULL,
	login varchar(255) NOT NULL,
	senha varchar(255) NOT NULL,
	PRIMARY KEY (`id_pessoa`)
)engine=InnoDB default charset=utf8 collate utf8_unicode_ci;

CREATE TABLE `table_escola`(
	id_escola int(15) NOT NULL,
    nome_escola varchar(255) NOT NULL,
    estado varchar(255) NOT NULL,
	cidade varchar(255) NOT NULL,
	bairro varchar(255) NOT NULL,
	rua varchar(255) NOT NULL,
    PRIMARY KEY (`id_escola`)
) engine=InnoDB default charset=utf8 collate utf8_unicode_ci;


CREATE TABLE `table_disciplina`(
    id_disciplina int(15) NOT NULL,
	id_professor int(15) NOT NULL,
    nome_classe varchar(255) NOT NULL,
    data_inicio date NOT NULL,
    data_fim date NOT NULL,
    PRIMARY KEY (`id_disciplina`)
) engine=InnoDB default charset=utf8 collate utf8_unicode_ci;

CREATE TABLE `table_disciplina_estudante`(
    id_estudante int(15) NOT NULL,
    id_disciplina int(15) NOT NULL,
    nota int(15) NOT NULL,
    faltas int(15) NOT NULL,
    data_inicio date NOT NULL,
    data_fim date NOT NULL,
    PRIMARY KEY (`id_estudante`, `id_disciplina`)
) engine=InnoDB default charset=utf8 collate utf8_unicode_ci;

CREATE TABLE `table_enem`(
    id_estudante int(15) NOT NULL,
    nota int(15) NOT NULL,
    ano date NOT NULL,
    PRIMARY KEY (`id_estudante`)
) engine=InnoDB default charset=utf8 collate utf8_unicode_ci;

***FK de estudante para pessoa (cada estudante tem que estar vinculado a uma pessoa)
ALTER TABLE `table_estudante` ADD CONSTRAINT `fk_estudante_pessoa` FOREIGN KEY ( `id_pessoa` ) REFERENCES `table_pessoa` ( `id_pessoa` );
***FK de administrador para pessoa (cada administrador tem que estar vinculado a uma pessoa)
ALTER TABLE `table_administrador` ADD CONSTRAINT `fk_administrador_pessoa` FOREIGN KEY ( `id_pessoa` ) REFERENCES `table_pessoa` ( `id_pessoa` );
***FK de professor para pessoa (cada professor tem que estar vinculado a uma pessoa)
ALTER TABLE `table_professor` ADD CONSTRAINT `fk_professor_pessoa` FOREIGN KEY ( `id_pessoa` ) REFERENCES `table_pessoa` ( `id_pessoa` );
***FK de pessoa para escola (cada estudante tem que estar vinculado a uma escola)
ALTER TABLE `table_estudante` ADD CONSTRAINT `fk_estudante_escola` FOREIGN KEY ( `id_escola` ) REFERENCES `table_escola` ( `id_escola` );
***FK de disciplina para professor (cada disciplina tem que ter um professor vinculado)
ALTER TABLE `table_disciplina` ADD CONSTRAINT `fk_disciplina_professor` FOREIGN KEY ( `id_professor` ) REFERENCES `table_professor` ( `id_professor` );
***FK de disciplina_estudante para estudante e disciplina (Cada disciplina cursada pelo estudante tem que ter vinculado a disciplina e o estudante que cursa a mesma)
ALTER TABLE `table_disciplina_estudante` ADD CONSTRAINT `fk_disciplina_estudante_estudante` FOREIGN KEY ( `id_estudante` ) REFERENCES `table_estudante` ( `id_estudante` );
ALTER TABLE `table_disciplina_estudante` ADD CONSTRAINT `fk_disciplina_estudante_disciplina` FOREIGN KEY ( `id_disciplina` ) REFERENCES `table_disciplina` ( `id_disciplina` );
***FK de professor_escola para professor e escola (O mesmo professor pode dar aula em diversas escolas diferentes)
ALTER TABLE `table_professor_escola` ADD CONSTRAINT `fk_professor_escola_professor` FOREIGN KEY ( `id_professor` ) REFERENCES `table_professor` ( `id_professor` );
ALTER TABLE `table_professor_escola` ADD CONSTRAINT `fk_professor_escola_escola` FOREIGN KEY ( `id_escola` ) REFERENCES `table_escola` ( `id_escola` );
***FK de enem para estudante (Cada nota do enem é necessário estar vinculado a um estudante)
ALTER TABLE `table_enem` ADD CONSTRAINT `fk_enem_estudante` FOREIGN KEY ( `id_estudante` ) REFERENCES `table_estudante` ( `id_estudante` );

