/*Escreva uma SP que receba, como parâmetro, o CPF de um autor e retorne a quantidade de livros escrito pelo mesmo.*/
drop procedure qtd_livros_escritos_pelo_autor;
delimiter $$

create procedure qtd_livros_escritos_pelo_autor(p_cpf varchar(14))
begin
     select Autores.nome as nome_autor , count(Autores_livros.id_livro) as qtd_livros
     from Autores_livros
         join Autores
             on Autores_livros.id_autor = Autores.id
     where Autores.cpf = p_cpf;
end $$
delimiter ;

call qtd_livros_escritos_pelo_autor('097.362.560-06');


/*Crie uma SP que receba, como um parâmetro, a data de publicação de um livro e seu código.
  O procedimento deve atualizar a tabela de livros, especificando a data de lançamento para o livro em questão.*/

delimiter $$

create procedure atualiza_data_lacamento_por_parametro(p_data_publicacao date, p_cod int)
begin
    update Livros set data_publicao = p_data_publicacao where id = p_cod;
end $$

delimiter ;

/*
Em algumas situações, SPs são utilizados para a manutenção da segurança do banco de dados. Nestes casos, realizamos inclusões, alterações e exclusões de dados, através de SPs. Crie SPs que recebem os parâmetros adequados e realizam as seguintes operações:

a) Inserir uma linha na tabela de livros
b) Excluir uma linha da tabela de livros
c) Atualizar valores na tabela de livros
*/

--a:
delimiter $$

create procedure add_linha_tabela_livros(p_titulo varchar(50), p_valor_unit double, p_data_publicacao date)
begin
    insert into Livros(titulo, valor_unit, data_publicao) values(p_titulo, p_valor_unit, p_data_publicacao)
end $$

delimiter ;

--b:
delimiter $$

create procedure deleta_linha_tabela_livros(p_cod int)
begin
    delete from Livros where id = p_cod;
end $$

delimiter ;

--c:

delimiter $$

create procedure atualiza_linha_tabela_livros(p_cod int, p_valor_unit double = null, p_data_publicacao date = null)
begin
    if p_valor_unit != null and p_data_publicacao != null
    begin
        update Livros set valor_unit = p_valor_unit, data_publicao = p_data_publicacao where id = p_cod;
    end

    if p_valor_unit != null
    begin
        update Livros set valor_unit = p_valor_unit where id = p_cod;
    end

    if p_data_publicacao != null
    begin 
        update Livros set data_publicao = p_data_publicacao where id = p_cod;
    end

end $$

delimiter ;

/*
Crie uma SP que aumente ou diminua o valor dos preços dos livros de uma editora específica. O aumento pode ser em percentual ou em valor.
*/

delimiter $$

create procedure alterar_preco_livro(p_cod_editora int, p_valor_unit double = null, p_porcentagem = null, p_op int)
begin

    if p_op = 1
    begin
        if p_valor_unit != null
            update Livros set valor_unit += p_valor_unit where editora.id = p_cod_editora;
        if p_porcentagem != null
            update Livros set valor_unit = valor_unit * (1 + (p_porcentagem / 100)) where editora.id = p_cod_editora;
    end

    if op = 2
    begin
        if p_valor_unit != null
            update Livros set valor_unit -= p_valor_unit where editora.id = p_cod_editora;
        if p_porcentagem != null
            update Livros set valor_unit = valor_unit * (1 - (p_porcentagem / 100)) where editora.id = p_cod_editora;
    end

end $$
delimiter ;

