Clientes(id, nome)
Livros (id, titulo, valor_unit)
Autores(id, nome)
Autores_livros(id_autor, id_livro)
Vendas(id, data, id_cliente)
vendas_livros(id, id_venda, id_livro, qtd, valor_unit)

-- 1 Crie uma view chamada "livros_mais_vendidos" que exiba o título, autor, preço e a quantidade de vezes que cada livro foi vendido.
CREATE VIEW livros_mais_vendidos AS
SELECT Livros.titulo as titulo, Autores.nome as nome_autor, Livros.valor_unit as preco, COUNT(vendas_livros.id_livro) as qtd_livro_vendido
FROM Livros
    JOIN Autores_livros
        on Livros.id = Autores_livros.id_livro
    JOIN Autores
        ON Autores.id = Autores_livros.id_autor
    JOIN vendas_livros
        ON vendas_livros.id_livro = Livros.id
GROUP BY Livros.nome
--dúvidas sobre este group by"

--2 Crie uma view que lista os autores que nunca venderam livros.
CREATE VIEW autores_nunca_venderam AS
SELECT Autores.nome as nome_autor
FROM Autores
    LEFT JOIN Autores_livros
        ON Autores_livros.id_autor = Autores.id
    JOIN Livros
        ON Livros.id = Autores_livros.id_livro
    JOIN vendas_livros
        ON Livros.id = vendas_livros.id_livro
WHERE vendas_livros.id_livro IS NULL

--3 Use a sua criatividade e crie uma view que se aplique nessa modelagem.
--Clientes que mais compraram
CREATE VIEW clientes__que_mais_compraram AS
SELECT Clientes.nome as nome_cliente, COUNT(Vendas.id_cliente) as qtd_compras
FROM Clientes
    JOIN Vendas
        ON Clientes.id = Vendas.id_cliente
GROUP BY Clientes.nome



