/*Bloco 3.5 - Perfil etario por segmento de cliente*/
USE ecommerce_nexashop;
SELECT segmento, ROUND(AVG(TIMESTAMPDIFF(YEAR, data_nascimento, CURDATE())), 1) AS idade_media
FROM clientes
GROUP BY segmento
ORDER BY idade_media DESC;
