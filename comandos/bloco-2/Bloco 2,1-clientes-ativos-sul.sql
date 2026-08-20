/*Bloco 2.1 - Clientes ativos da regiao Sul*/
USE ecommerce_nexashop;
SELECT nome, cidade, estado, status
FROM clientes
WHERE status = 'Ativo' AND estado IN ('SC', 'PR', 'RS')
ORDER BY estado, nome;
