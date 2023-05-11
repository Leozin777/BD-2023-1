-- Categorias
INSERT INTO categorias (id, nome) VALUES
(1, 'Bebidas'),
(2, 'Lanches'),
(3, 'Doces'),
(4, 'Salgados');

-- Receitas
INSERT INTO receitas (id, nome) VALUES
(1, 'Suco de Laranja'),
(2, 'Hambúrguer'),
(3, 'Brigadeiro'),
(4, 'Coxinha');

-- Produtos
INSERT INTO produtos (id, id_categoria, id_receita, nome) VALUES
(1, 1, 1, 'Suco de Laranja Natural'),
(2, 1, 1, 'Suco de Laranja com açúcar'),
(3, 2, 2, 'Hambúrguer Simples'),
(4, 2, 2, 'Hambúrguer Duplo'),
(5, 3, 3, 'Brigadeiro Tradicional'),
(6, 4, 4, 'Coxinha de Frango');

-- Ingredientes
INSERT INTO ingredientes (id, nome) VALUES
(1, 'Laranja'),
(2, 'Água'),
(3, 'Açúcar'),
(4, 'Pão de hambúrguer'),
(5, 'Carne de hambúrguer'),
(6, 'Leite condensado'),
(7, 'Chocolate em pó'),
(8, 'Farinha de trigo'),
(9, 'Leite'),
(10, 'Frango');

-- Receitas_ingredientes
INSERT INTO receitas_ingredientes (id, id_ingrediente, id_receita_ingrediente) VALUES
(1, 1, 1),
(2, 2, 1),
(3, 3, 2),
(4, 4, 2),
(5, 5, 2),
(6, 6, 3),
(7, 7, 3),
(8, 8, 4),
(9, 9, 4),
(10, 10, 4);

-- Estoque
INSERT INTO estoque (id, id_ingredientes, id_produto) VALUES
(1, 1, 1),
(2, 2, 1),
(3, 3, 2),
(4, 4, 3),
(5, 5, 3),
(6, 6, 4),
(7, 7, 4),
(8, 8, 6),
(9, 9, 6),
(10, 10, 6);

insert into ingredientes (id, nome) values
(11, 'Ovo'),
(12, 'Manteiga'),
(13, 'Chocolate');

