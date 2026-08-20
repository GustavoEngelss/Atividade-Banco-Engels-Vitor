/*Bloco 4.2 - Separacao de Avaliacoes*/
USE ecommerce_nexashop;
SELECT
CASE
WHEN nota = 5 THEN 'Excelente'
WHEN nota = 4 THEN 'Boa'
WHEN nota = 3 THEN 'Regular'
WHEN nota IN (1, 2) THEN 'Insatisfatória'
END AS classificacao,
COUNT(*) AS quantidade_avaliacoes
FROM avaliacoes
GROUP BY classificacao
ORDER BY quantidade_avaliacoes DESC;
