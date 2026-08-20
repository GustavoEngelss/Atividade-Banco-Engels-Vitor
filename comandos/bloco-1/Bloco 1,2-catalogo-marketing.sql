/*Bloco 1.2 - Catalogo de produtos para o marketing*/
USE ecommerce_nexashop;
SELECT nome, categoria, marca, preco AS 'Valor (R$)', estoque
FROM produtos;
