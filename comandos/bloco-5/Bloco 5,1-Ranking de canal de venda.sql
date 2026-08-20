/*Bloco 5.1 - Ranking de canal de venda e forma de pagamento*/
USE ecommerce_nexashop;
SELECT
canal_venda,
forma_pagamento,
COUNT(*) AS quantidade_pedidos,
SUM(valor_total) AS faturamento
FROM pedidos
WHERE status = 'Aprovado'
GROUP BY canal_venda, forma_pagamento
HAVING COUNT(*) >= 200
ORDER BY faturamento DESC
LIMIT 5;
