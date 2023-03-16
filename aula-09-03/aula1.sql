clientes (id, nome)
vendas (id, nome)
produtos (id, nome)
vendas_produtos (id, data, id_produto, id_venda, qtd, val_unit)
forma_pagamento (id, nome)
forma_pagamento_venda (id_venda, id_forma_pagamento, valor, quants_vezes)


/*Listar todos os produtos vendidos no mês de fevereiro de 2023*/


select produtos.nome as nome_produto
from vendas v
    join vendas_produtos vp
        on v.id = vp.id_venda
    join produtos p
        on vp.id_produto = p.id        
where v.data => '2023-02-01' and v.data <= '2023-02-28'  


/*listar o valor total de vendas por forma de pagamento no mes de fev. 23 */


select sum(vp.qtd * vp.val_unit) as total_vendas
from forma_pagamento_venda fpv
    join vendas v
        on fpv.id_venda = v.id
    join forma_pagamento fp
        on fp.id = fpv.id_forma_pagamento
    join vendas_produtos vp
        on vp.id_venda = v.id
where v.data => '2023-02-01' and v.data <= '2023-02-28'  
group by fp.nome