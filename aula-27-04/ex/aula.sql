CREATE TABLE setores
(
	id int auto_increment primary key,
    nome varchar(50) not null,
    total_salario decimal(18,2) default 0
);
insert into setores (nome)
	values ('Dev'), ('Suporte'),('Finan');

insert into setores (nome)
    values ('Dev'), ('Suporte'), ('Jake');

CREATE TABLE funcionarios
(
	id int auto_increment primary key,
    nome varchar(50) not null,
    salario decimal(18,2) default 0,
    id_setor int,
    constraint funcionarios_setores_fk
		foreign key(id_setor)
			references setores(id)
				ON DELETE RESTRICT
                ON UPDATE CASCADE
);

DELIMITER $$
CREATE TRIGGER trigger_atualiza_total_salario AFTER INSERT ON funcionarios
    FOR EACH ROW
BEGIN
    UPDATE setores set total_salario = total_salario + NEW.salario
    WHERE id = NEW.id;
end $$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER trigger_atualiza_total_salario_quando_deleta AFTER DELETE ON funcionarios
    FOR EACH ROW
BEGIN
    UPDATE setores set total_salario = total_salario - OLD.salario
    WHERE id = OLD.id;
end $$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER trigger_atualiza_total_salario_quando_update AFTER UPDATE ON funcionarios
	FOR EACH ROW
BEGIN
    UPDATE setores set total_salario = (NEW.salario - OLD.salario) + total_salario
    WHERE id = NEW.id;
END $$
DELIMITER ;

insert into funcionarios(nome, salario, id_setor)
values ('Silva', 500, 1);

select * from funcionarios;
