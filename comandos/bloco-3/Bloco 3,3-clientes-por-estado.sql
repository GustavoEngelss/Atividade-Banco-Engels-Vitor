/*Bloco 3.3 - Onde estao os clientes da NexaShop*/
USE ecommerce_nexashop;
SELECT estado, COUNT(*) AS quantidade_clientes
FROM clientes
GROUP BY estado
ORDER BY quantidade_clientes DESC;
