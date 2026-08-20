/*Bloco 2.4 - Pedidos de ticket intermediario aprovados*/
USE ecommerce_nexashop;
SELECT id, valor_total, forma_pagamento, canal_venda, status
FROM pedidos
WHERE status = 'Aprovado' AND valor_total BETWEEN 100 AND 500
ORDER BY valor_total DESC;
