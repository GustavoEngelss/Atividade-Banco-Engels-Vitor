/*Bloco 3.2 - Faturamento por forma de pagamento*/
USE ecommerce_nexashop;
SELECT forma_pagamento, SUM(valor_total) AS faturamento
FROM pedidos
WHERE status = 'Aprovado'
GROUP BY forma_pagamento
ORDER BY faturamento DESC;
