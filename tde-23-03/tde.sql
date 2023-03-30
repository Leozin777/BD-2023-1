CREATE TABLE produtos (
    id int auto_increment, 
    nome varchar(50) not null,
    valor double,
    saldo double 
)

INSERT INTO produtos (nome, valor, saldo)
VALUES
    ('Produto 1', 9.99, 20),
    ('Produto 2', 15.50, 30),
    ('Produto 3', 25.00, 10);

/*Saldo é a quantidade atual em estoque de um produto*/

CREATE TABLE orcamentos (
   id int auto_increment, 
   data Date not null,
   status varchar(20) not null 
)

INSERT INTO orcamentos (data, status)
VALUES
    ('02-03-2023', 'em orçamento'),
    ('05-04-2022', 'vendido'),
    ('02-03-2022', 'cancelado');

/*
Status:
    em orçamento
    vendido
    cancelado
*/

CREATE TABLE orçamentos_itens(
    id_prod int auto_increment,
    id_orc int,
    valor_unit double,
    quantidade int,
    valor_total_item,
    constraint id_orc_fk
    foreign key(id_orc) references(orcamentos)
)
/*
valor total do item é o valor_unit * quantidade. No insert já tem que informar.
*/



/*C*/
SELECT Orcamentos.id as Identificador_Orcamento, produtos.nome
FROM Orcamentos
    JOIN Orcamentos_Itens
        ON Orcamentos.id = Orcamentos_Itens.id_orc
    JOIN produtos
        ON Orcamentos_Itens.id_prod = produtos.id
GROUP BY Orcamentos.id
UNION
SELECT produtos.nome as produto, produtos.valor as valor_produto ,Orcamentos.data as data_orcado
FROM Orcamentos
    JOIN Orcamentos_Itens
        ON Orcamentos.id = Orcamentos_Itens.id_orc
    JOIN produtos
        ON Orcamentos_Itens.id_prod = produtos.id
WHERE Orcamentos.data => '01-03-2022' AND Orcamentos.data <= '31-03-2022'
UNION
SELECT produtos.nome as nome_produto, produtos.saldo
FROM produtos
WHERE produtos.saldo > 0
UNION
SELECT produtos.nome as nome_produto, produtos.saldo
FROM Orcamentos
    JOIN Orcamentos_Itens
        ON Orcamentos.id = Orcamentos_Itens.id_orc
    JOIN produtos
        ON Orcamentos_Itens.id_prod = produtos.id


/*F*/
/*Devemos utilizar o GROUP BY quando quisermos agrupar os resultados
de uma query.
    Esta querry retorna a quantidade de alunos em cada sala*/
SELECT salas.id as num_sala, SUM(alunos.id) AS qtd_aluno
FROM alunos
    JOIN salas
        ON alunos.id_sala = salas.id
GROUP BY salas.id




/*Devemos utilizar o HAVING quando queros os resultados de uma query que utiliza alguma função
como o SUM, AVG, MAX e etc.
    Essa query retorna somente as salas que possuem mais
de 30 alunos*/
SELECT SUM(alunos.id) AS qtd_aluno, salas.id as num_sala
FROM alunos
    JOIN salas
        ON alunos.id_sala = salas.id
GROUP BY salas.id
HAVING SUM(alunos.id) > 30


/*o UNION é utilizado para juntar os resultados de outras consultas*/


/*o LEFT JOIN é utilizado quando queremos exibir
todo o valor da esquerda e a interseção entre duas tabelas
    Esta query ira retornar uma coluna com todas as salas e
outra com a quantidade de alunos por sala, se a sala não tiver
nenhum aluno, a coluna 'qtd_aluno' vai ser nula*/
SELECT salas.id as num_sala, SUM(alunos.id) as qtd_aluno
FROM salas
    LEFT JOIN alunos
        ON salas.id = alunos.id_sala
GROUP BY salas.id



SELECT p.nome
FROM produtos p, orcamentos_itens oi
WHERE p.id = oi.id_produto is null