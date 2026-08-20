/*Bloco 2.2 - Busca de cliente por nome (tela de atendimento)*/
USE ecommerce_nexashop;
SELECT id, nome, email, cidade, estado
FROM clientes
WHERE nome LIKE '%Silva%';
