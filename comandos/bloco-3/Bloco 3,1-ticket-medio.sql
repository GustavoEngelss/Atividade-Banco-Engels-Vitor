/*Bloco 3.1 - Radar de ticket medio*/
USE ecommerce_nexashop;
SELECT
COUNT(*) AS 'Quantidade de Pedidos',
ROUND(AVG(valor_total), 2) AS 'Ticket Medio (R$)',
MIN(valor_total) AS 'Menor Valor (R$)',
MAX(valor_total) AS 'Maior Valor (R$)'
FROM pedidos
WHERE status = 'Aprovado';
