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
    constraint producao_fk_produtos
    foreign key (id_produto) references produtos(id)
    on delete restrict
    on update cascade
);
