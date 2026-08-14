/*Bloco 4.1 - Classificando Avaliação*/
USE ecommerce_nexashop;
select 
	id,
    nota,
    case
		when nota = 5 then 'Exelente'
        when nota = 4 then 'Boa'
        when nota = 3 then 'Regular'
        when nota in (1, 2) then 'Insatisdatória'
	end as classificacao
from avaliacoes
