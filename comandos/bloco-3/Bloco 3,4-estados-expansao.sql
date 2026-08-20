/*Bloco 3.4 - Estados prioritarios para expansao*/
USE ecommerce_nexashop;
SELECT estado, COUNT(*) AS quantidade_clientes
FROM clientes
GROUP BY estado
HAVING COUNT(*) > 200
ORDER BY quantidade_clientes DESC;
