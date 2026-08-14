/*Bloco 5.1 - Ranking de canal de venda*/
USE ecommerce_nexashop;
select
	canal_venda,
    forma_pagamento,
    count(*) as 'Quantidades de Pedidos',
    sum(valor_total) as 'Faturamento (R$)'
from pedidos 
where status = 'Aprovado'
group by
	canal_venda,
    forma_pagamento
having count(*) >= 200
order by 'Faturamento (R$)' desc
limit 5;