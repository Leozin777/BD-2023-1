select adm.id_administrador, COUNT(c.id_corrida) as total_corridas, AVG(c.krn) as km_media
from CorridasPorCliVeiAdmFun CCAF
join Administradores adm 
    on CCAF.id_administrador = adm.id_administrador
join Corridas c 
    on CCAF.id_corrida = c.id_corrida
where c.data_corrida >= '2015-07-01' and c.data_corrida < '2015-08-01'
group by adm.id_administrador



select adm.id_administrador, COUNT(c.id_corrida) as total_corridas, AVG(c.krn) as km_media
from CorridasPorEntidade cpe
join Administradores a on cpe.id_administrador = a.id_administrador
join Corridas c on cpe.id_corrida = c.id_corrida
where c.data_corrida >= '2015-07-01' and c.data_corrida < '2015-08-01'
group by a.id_administrador;



create trigger atualizaFluxoCaixa
on Despesas
after insert, delete
as
begin
    if exists (select 1 from inserted)
    begin
        update FluxoCaixa
        set saldo = saldo + (SELECT SUM(valor) FROM inserted)
        where mes = (SELECT DISTINCT MONTH(data) FROM inserted);
    END;
    
    if exists (select 1 from deleted)
    begin
        update FluxoCaixa
        set saldo = saldo - (SELECT SUM(valor) FROM deleted)
        where mes = (SELECT DISTINCT MONTH(data) FROM deleted);
    end;
end;
