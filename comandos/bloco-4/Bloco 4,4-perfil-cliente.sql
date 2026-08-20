/*Bloco 4.4 - Perfil de relacionamento dos clientes*/
USE ecommerce_nexashop;
SELECT
CASE
WHEN TIMESTAMPDIFF(YEAR, data_cadastro, CURDATE()) < 1 THEN 'Novo'
WHEN TIMESTAMPDIFF(YEAR, data_cadastro, CURDATE()) BETWEEN 1 AND 3 THEN 'Fiel'
WHEN TIMESTAMPDIFF(YEAR, data_cadastro, CURDATE()) > 3 THEN 'Veterano'
END AS perfil,
COUNT(*) AS quantidade_clientes
FROM clientes
GROUP BY perfil
ORDER BY quantidade_clientes DESC;
