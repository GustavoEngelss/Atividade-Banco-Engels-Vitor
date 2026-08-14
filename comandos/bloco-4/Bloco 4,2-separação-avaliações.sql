/*Bloco 4.2 - Separação de Avaliações*/
USE ecommerce_nexashop;
select
	case
	when nota = 5 then 'Exelente'
	when nota = 4 then 'Boa'
	when nota = 3 then 'Regular'
	when nota in (1, 2) then 'Insatisdatória'
    end as classificacao,
    count(*) as 'Quantidade de Avaliações'
from avaliacoes
group by classificacao
order by 'Quantidade de Avaliações' desc;    