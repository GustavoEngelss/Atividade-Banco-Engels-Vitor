/*Bloco 4.3 - Taxa de Aprovação*/
USE ecommerce_nexashop;
select 
	round(
		avg(
			case 
				when status = 'Aprovado' then 1
				else 0
			end
			) * 100,
			2
		)as 'Taxa de Aprovação (%)'
from pedidos;