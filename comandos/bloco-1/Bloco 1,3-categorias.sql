/*Bloco 1.3 - Quantas categorias a loja realmente vende*/
USE ecommerce_nexashop;
SELECT DISTINCT categoria
FROM produtos
ORDER BY categoria ASC;
