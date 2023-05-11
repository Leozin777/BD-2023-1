create table categorias
(
    id int primary key,
    nome varchar(30) not null
);

create table produtos
(
    id int primary key,
    id_categoria int not null,
    nome varchar(30) not null,
    data_validade date not null,
    constraint produtos_fk_categorias
    foreign key (id_categoria) references categorias(id)
    on delete restrict
    on update cascade
);

create table ingredientes
(
    id int primary key,
    nome varchar(30) not null
);

create table receitas
(
    id int primary key,
    nome varchar(30) not null,
    qtd_ingredientes int not null,
    id_ingrediente int not null,
    id_produto int not null,
    constraint receitas_fk_ingredientes
    foreign key (id_ingrediente) references ingredientes(id)
    on delete restrict
    on update cascade,
    constraint receitas_fk_produtos
    foreign key (id_produto) references produtos(id)
    on delete restrict
    on update cascade
);

create table estoque
(
    id int primary key,
    id_ingredientes int,
    qtd_estoque int not null,
    constraint estoque_fk_ingredientes
    foreign key (id_ingredientes) references ingredientes(id)
    on delete restrict
    on update cascade
);

create table producao
(
    id int primary key,
    id_produto int,
    qtd_produzida int not null,
    data_producao date not null,
    constraint producao_fk_produtos
    foreign key (id_produto) references produtos(id)
    on delete restrict
    on update cascade
);

INSERT INTO categorias (id, nome)
VALUES (1, 'Bebidas'), (2, 'Comidas'), (3, 'Sobremesas');

INSERT INTO produtos (id, id_categoria, nome, data_validade)
VALUES (2, 2, 'Pizza', '2023-05-20'),
       (3, 3, 'Sorvete', '2023-07-15'),
       (4, 1, 'Suco', '2023-06-30');

INSERT INTO ingredientes (id, nome)
VALUES (1, 'Queijo'), (2, 'Tomate'), (3, 'Massa'), (4, 'Agua'), (5, 'Laranja');

INSERT INTO receitas (id, nome, qtd_ingredientes, id_ingrediente, id_produto)
VALUES (1, 'Pizza de Queijo', 3, 1, 2),
       (2, 'Pizza de Tomate', 3, 2, 2),
       (3, 'Sorvete de Chocolate', 1, 3, 3),
       (4, 'Suco de laranja', 2, 5, 4);

INSERT INTO estoque (id, id_ingredientes, qtd_estoque)
VALUES (1, 1, 50), (2, 2, 30), (3, 3, 20);

INSERT INTO producao (id, id_produto, qtd_produzida, data_producao)
VALUES (1, 2, 10, '2023-05-10'), (2, 3, 5, '2023-05-09'), (3, 2, 10, '2023-01-20'), (4, 4, 5, '2023-05-11');

-- Exibir quantos produtos há para cada categoria;

select c.nome as nome_da_categoria, count(p.id) as qtd_produtos
from produtos p
    inner join categorias c on p.id_categoria = c.id
group by c.nome;

-- Exibir todos os produtos, quais ingredientes e em que quantidade são  utilizados para produzi-lo;

select p.nome as nome_produto, i.nome as nome_ingredientes, r.qtd_ingredientes as qtd_ingredientes
from produtos p
    left join receitas r
        on p.id = r.id_produto
    left join ingredientes i
        on i.id = r.id_ingrediente;

-- Exibir qual a quantidade produzida de cada produto dos últimos 30 dias

select produtos.nome as nome_produto, sum(pd.qtd_produzida) as qtd_produzida
from produtos
    join producao pd
        on produtos.id = pd.id_produto
where pd.data_producao >= date_sub(curdate(), interval 30 day)
group by produtos.nome;

-- Se for dobrada a produção para o próximo mês, quanto de ingrediente será  necessário.

select i.nome as ingrediente, sum((pd.qtd_produzida * r.qtd_ingredientes)* 2) as qtd_em_dobro_necessaria_prox_mes
from receitas r
	join produtos p
	    on p.id = r.id_produto
	join ingredientes i
		on i.id = r.id_ingrediente
	join producao pd
		on p.id = pd.id_produto
where pd.data_producao >= date_sub(curdate(), interval 30 day)
group by i.id;

-- Mostrar os ingredientes que nunca foram utilizados

select i.nome as nome_ingredientes
    from ingredientes i
    left join receitas r
        on i.id = r.id_ingrediente
    right join estoque e on i.id = e.id_ingredientes;

-- essa não funciona

-- Crie uma trigger para garantir o controle de estoque dos produtos fabricados.
-- Quanto um produto for fabricado deve dar saída dos estoque dos ingredientes utilizados.
-- Caso ocorra o estorno da fabricação, manter o estoque dos ingredientes atualizado também;

-- não consegui fazer :/

-- Utilizando controle de transações, atualize as receitas para reduzir em 10% a  quantidade de fermento utilizada;
START TRANSACTION;

update receitas
set qtd_ingredientes = qtd_ingredientes * 0.9
where id_ingrediente = (select id from ingredientes where nome = 'fermento');

-- Confirme a transação do exercício anterior;
COMMIT;

-- Utilizando controle de transações, exclua todos os registros de produção do  último mês;

START TRANSACTION;

delete from producao
where data_producao >= date_sub(current_date(), interval 30 day);


-- Desfaça a transação realizada no exercício anterior;
rollback;
