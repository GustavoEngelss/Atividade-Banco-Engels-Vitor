/*Bloco 2.5 - Alerta de reposicao de estoque*/
USE ecommerce_nexashop;
SELECT nome, categoria, estoque
FROM produtos
WHERE ativo = 1 AND estoque < 10
ORDER BY estoque ASC;
