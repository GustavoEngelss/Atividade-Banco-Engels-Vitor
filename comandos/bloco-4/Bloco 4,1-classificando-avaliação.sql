/*Bloco 4.1 - Classificando Avaliação*/
USE ecommerce_nexashop;
select 
	id,
    nota,
    case
		when nota = 5 then 'Excelente'
        when nota = 4 then 'Boa'
        when nota = 3 then 'Regular'
        when nota in (1, 2) then 'Insatisfatória'
	end as classificacao
from avaliacoes
