/*Bloco 5.3 - Invetigando Forma de pagamento*/
USE ecommerce_nexashop;
select
	forma_pagamento,
    round(
		avg(
			case
				when status = 'Cancelado' then 1
                else 0
                end
		    ) * 100,
            2
        ) as 'Taxa de Cancelamento (%)'
from pedidos
group by forma_pagamento
order by 'Taxa de Cancelamento (%)' desc;