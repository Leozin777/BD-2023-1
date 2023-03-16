/*1:Escreva uma consulta que retorne o nome do cliente, a soma do valor total das compras
e o número total de pedidos feitos por cada cliente, apenas para aqueles que fizeram pelo menos três pedidos.
Use um inner join entre as tabelas "clientes" e "pedidos" e agrupe os resultados pelo nome do cliente.*/

SELECT c.nome as nome_do_cliente,SUM(p.valor_total) as valor_total_compras, COUNT(p.id) as total_de_pedidos
FROM clientes c
    JOIN pedidos p
        ON c.id = p.id_cliente
GROUP BY c.nome
HAVING COUNT(p.id) >= 3;

/*
 Escreva uma consulta que retorne o nome do produto, a média do preço de venda
 e a soma total de unidades vendidas por categoria de produto. Use um left join entre as tabelas
 "produtos" e "vendas" e agrupe os resultados pela categoria do produto.
 */

SELECT p.nome as nome_do_produto, AVG(v.preco_venda) as media_preco_venda, SUM(c.qtd_venda) as soma_total_qtd
FROM produtos p
    LEFT JOIN vendas v
        ON v.id_produto = p.id
    JOIN categorias c
        ON p.id_categoria = c.id
GROUP BY c.nome;

/*
Escreva uma consulta que retorne o nome do fornecedor, o nome do produto e o número total
de unidades compradas por fornecedor e por produto, apenas para aqueles com mais de 100 unidades compradas.
Use um inner join entre as tabelas "fornecedores", "produtos" e "compras" e agrupe os resultados pelo nome
do fornecedor e pelo nome do produto.
*/
fornecedores(id, nome)
produtos(id, nome, valor_unt)
vendas(id, data, valor_total, id_fornecedor)
vendas_produtos(id, qtd_vendida, valor_produtos, id_produto, id_vendas)

SELECT f.nome as nome_fornecedor, p.nome as nome_produto, SUM(vp.qtd_vendida) as unidade_comprada_fornecedor_produto
FROM fornecedores f
    JOIN vendas v
        ON f.id = v.id_fornecedor
    JOIN vendas_produtos vp
        ON v.id = vp.id_vendas
    JOIN produtos p
        ON p.id =  vp.id_produto
GROUP BY f.nome, p.nome
HAVING COUNT(vp.qtd_vendida) >= 100

/*
 Escreva uma consulta que retorne o nome do departamento, o nome do funcionário e a média do salário
 dos funcionários em cada departamento, apenas para aqueles com uma média de salário superior a R$ 5000.
 Use um left join entre as tabelas "funcionarios" e "departamentos" e agrupe os resultados pelo nome do
 departamento e pelo nome do funcionário.
 */

departamentos(id, nome)
funcionarios(id, nome, salario, id_departamento)

SELECT d.nome as nome_departamento, f.nome as nome_funcionario, AVG(f.salario) as media_salario_departamento
FROM departamentos d
    LEFT JOIN funcionarios f
        ON d.id = f.id_departamento
GROUP BY d.nome, f.nome
HAVING AVG(f.salario) > 5000

/*
 Escreva uma consulta que retorne o nome do cliente, o nome do produto e a soma do valor
 total das compras feitas por cada cliente para cada produto. Use um right join entre as tabelas "clientes"
 e "compras" e um inner join entre as tabelas "produtos" e "compras" e agrupe os resultados pelo nome do cliente
 e pelo nome do produto.
 */

clientes(id, nome)
produtos(id, nome, valor_unit)
compras(id, valor_total, id_produto, id_cliente)

SELECT c.nome as nome_cliente, p.nome as nome_produto, SUM(cp.valor_total) as soma valor_total_cliente_produto
FROM clientes c
    RIGHT JOIN compras cp
        ON c.id = cp.id_cliente
    JOIN produtos p
        ON p.id = cp.id_produto
GROUP BY c.nome, p.nome


