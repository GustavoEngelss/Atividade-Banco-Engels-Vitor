/*Bloco 5.3 - Investigando forma de pagamento (taxa de cancelamento)*/
USE ecommerce_nexashop;
SELECT
forma_pagamento,
ROUND(AVG(CASE WHEN status = 'Cancelado' THEN 1 ELSE 0 END) * 100, 2) AS taxa_cancelamento
FROM pedidos
GROUP BY forma_pagamento
ORDER BY taxa_cancelamento DESC;
