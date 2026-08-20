/*Bloco 3.6 - Valor de estoque parado por categoria*/
USE ecommerce_nexashop;
SELECT categoria, SUM(preco * estoque) AS valor_estoque
FROM produtos
WHERE ativo = 1
GROUP BY categoria
ORDER BY valor_estoque DESC;
