create table receitas
(
     id int primary key,
     nome varchar(30) not null
);

create table receitas_ingredientes
(
    id int primary key,
    id_ingrediente int
);

create table produtos
(
    id int primary key,
    id_categoria int not null,
    id_receita int not null,
    nome varchar(30) not null,
    constraint produtos_fk_categorias
    foreign key (id_categoria) references categorias(id)
    on delete restrict
    on update cascade,
    constraint produtos_fk_receita
    foreign key (id_receita) references receitas(id)
    on delete restrict
    on update cascade
);

create table estoque
(
    id int primary key,
    id_ingredientes int,
    id_produto int,
    constraint estoque_fk_ingredientes
    foreign key (id_ingredientes) references ingredientes(id)
    on delete restrict
    on update cascade,
    constraint estoque_fk_produto
    foreign key (id_produto) references produtos(id)
    on delete restrict
    on update cascade
);

create table ingredientes
(
    id int primary key,
    nome varchar(30) not null
);

create table categorias
(
    id int primary key,
    nome varchar(30) not null
);