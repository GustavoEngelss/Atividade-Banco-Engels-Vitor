/*Bloco 2.6 - Alcance das campanhas de cupom*/
USE ecommerce_nexashop;
SELECT id, valor_total, cupom_desconto
FROM pedidos
WHERE cupom_desconto IS NOT NULL;
