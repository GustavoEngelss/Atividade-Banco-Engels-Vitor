/*Bloco 2.3 - Clientes sem telefone cadastrado*/
USE ecommerce_nexashop;
SELECT nome, email, cidade, estado
FROM clientes
WHERE telefone IS NULL;
