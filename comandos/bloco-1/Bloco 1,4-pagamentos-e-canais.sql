/*Bloco 1.4 - Formas de pagamento e canais de venda aceitos*/
USE ecommerce_nexashop;
SELECT DISTINCT forma_pagamento FROM pedidos;
SELECT DISTINCT canal_venda FROM pedidos;
