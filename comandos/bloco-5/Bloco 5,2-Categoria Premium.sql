/*Bloco 5.2 - Categorias premium do catalogo*/
USE ecommerce_nexashop;
SELECT
categoria,
COUNT(*) AS quantidade_produtos,
ROUND(AVG(preco), 2) AS preco_medio
FROM produtos
WHERE ativo = 1
GROUP BY categoria
HAVING AVG(preco) > 300
ORDER BY preco_medio DESC;
