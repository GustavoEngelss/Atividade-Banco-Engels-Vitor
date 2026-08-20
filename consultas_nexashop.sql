/* ============================================================
ATIVIDADE DE CONSOLIDACAO - CONSULTAS SQL COM MYSQL
Cenario: NexaShop (e-commerce ficticio)
Dupla: Vitor Cesar da Silva e Gustavo Engels
Banco: ecommerce_nexashop
============================================================ */

USE ecommerce_nexashop;

/* ------------------------------------------------------------
ATIVIDADE 0 - Validacao do ambiente
Confere se a base foi importada corretamente.
------------------------------------------------------------ */
SELECT 'clientes' AS tabela, COUNT(*) AS total FROM clientes
UNION ALL
SELECT 'produtos' AS tabela, COUNT(*) AS total FROM produtos
UNION ALL
SELECT 'pedidos' AS tabela, COUNT(*) AS total FROM pedidos
UNION ALL
SELECT 'avaliacoes' AS tabela, COUNT(*) AS total FROM avaliacoes;

/* ============================================================
BLOCO 1 - RECONHECIMENTO DO BANCO
============================================================ */

/* 1.1 - Primeiro contato: 10 primeiras linhas de cada tabela */
SELECT * FROM clientes LIMIT 10;
SELECT * FROM produtos LIMIT 10;
SELECT * FROM pedidos LIMIT 10;
SELECT * FROM avaliacoes LIMIT 10;

/* 1.2 - Catalogo de produtos para o marketing (colunas amigaveis) */
SELECT nome, categoria, marca, preco AS 'Valor (R$)', estoque
FROM produtos;

/* 1.3 - Categorias sem repeticao, em ordem alfabetica */
SELECT DISTINCT categoria
FROM produtos
ORDER BY categoria ASC;

/* 1.4 - Formas de pagamento e canais de venda (duas consultas) */
SELECT DISTINCT forma_pagamento FROM pedidos;
SELECT DISTINCT canal_venda FROM pedidos;

/* ============================================================
BLOCO 2 - FILTROS, BUSCA TEXTUAL E ORDENACAO
============================================================ */

/* 2.1 - Clientes ativos da regiao Sul (SC, PR, RS) */
SELECT nome, cidade, estado, status
FROM clientes
WHERE status = 'Ativo' AND estado IN ('SC', 'PR', 'RS')
ORDER BY estado, nome;

/* 2.2 - Busca de cliente por parte do nome */
SELECT id, nome, email, cidade, estado
FROM clientes
WHERE nome LIKE '%Silva%';

/* 2.3 - Clientes sem telefone cadastrado */
SELECT nome, email, cidade, estado
FROM clientes
WHERE telefone IS NULL;

/* 2.4 - Pedidos aprovados de ticket intermediario (R$100 a R$500) */
SELECT id, valor_total, forma_pagamento, canal_venda, status
FROM pedidos
WHERE status = 'Aprovado' AND valor_total BETWEEN 100 AND 500
ORDER BY valor_total DESC;

/* 2.5 - Produtos ativos com estoque critico (menor que 10) */
SELECT nome, categoria, estoque
FROM produtos
WHERE ativo = 1 AND estoque < 10
ORDER BY estoque ASC;

/* 2.6 - Pedidos que usaram cupom de desconto */
SELECT id, valor_total, cupom_desconto
FROM pedidos
WHERE cupom_desconto IS NOT NULL;

/* ============================================================
BLOCO 3 - INDICADORES AGREGADOS
============================================================ */

/* 3.1 - Radar de ticket medio (somente pedidos aprovados) */
SELECT
COUNT(*) AS 'Quantidade de Pedidos',
ROUND(AVG(valor_total), 2) AS 'Ticket Medio (R$)',
MIN(valor_total) AS 'Menor Valor (R$)',
MAX(valor_total) AS 'Maior Valor (R$)'
FROM pedidos
WHERE status = 'Aprovado';

/* 3.2 - Faturamento por forma de pagamento */
SELECT forma_pagamento, SUM(valor_total) AS faturamento
FROM pedidos
WHERE status = 'Aprovado'
GROUP BY forma_pagamento
ORDER BY faturamento DESC;

/* 3.3 - Quantidade de clientes por estado */
SELECT estado, COUNT(*) AS quantidade_clientes
FROM clientes
GROUP BY estado
ORDER BY quantidade_clientes DESC;

/* 3.4 - Estados com mais de 200 clientes (HAVING) */
SELECT estado, COUNT(*) AS quantidade_clientes
FROM clientes
GROUP BY estado
HAVING COUNT(*) > 200
ORDER BY quantidade_clientes DESC;

/* 3.5 - Idade media por segmento de cliente */
SELECT segmento, ROUND(AVG(TIMESTAMPDIFF(YEAR, data_nascimento, CURDATE())), 1) AS idade_media
FROM clientes
GROUP BY segmento
ORDER BY idade_media DESC;

/* 3.6 - Valor de estoque parado por categoria (preco x estoque) */
SELECT categoria, SUM(preco * estoque) AS valor_estoque
FROM produtos
WHERE ativo = 1
GROUP BY categoria
ORDER BY valor_estoque DESC;

/* ============================================================
BLOCO 4 - CLASSIFICACAO COM CASE E REGRAS DE NEGOCIO
============================================================ */

/* 4.1 - Classificando cada avaliacao pela nota */
SELECT
id,
nota,
CASE
WHEN nota = 5 THEN 'Excelente'
WHEN nota = 4 THEN 'Boa'
WHEN nota = 3 THEN 'Regular'
WHEN nota IN (1, 2) THEN 'Insatisfatória'
END AS classificacao
FROM avaliacoes;

/* 4.2 - Quantidade de avaliacoes por faixa */
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

/* 4.3 - Taxa de aprovacao dos pedidos (em %) */
SELECT ROUND(AVG(CASE WHEN status = 'Aprovado' THEN 1 ELSE 0 END) * 100, 2) AS 'Taxa de Aprovação (%)'
FROM pedidos;

/* 4.4 - Perfil de relacionamento dos clientes */
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

/* ============================================================
BLOCO 5 - DESAFIO INTEGRADOR (SEM JOIN)
============================================================ */

/* 5.1 - Ranking de canal de venda e forma de pagamento (top 5) */
SELECT
canal_venda,
forma_pagamento,
COUNT(*) AS quantidade_pedidos,
SUM(valor_total) AS faturamento
FROM pedidos
WHERE status = 'Aprovado'
GROUP BY canal_venda, forma_pagamento
HAVING COUNT(*) >= 200
ORDER BY faturamento DESC
LIMIT 5;

/* 5.2 - Categorias premium (preco medio acima de R$300) */
SELECT
categoria,
COUNT(*) AS quantidade_produtos,
ROUND(AVG(preco), 2) AS preco_medio
FROM produtos
WHERE ativo = 1
GROUP BY categoria
HAVING AVG(preco) > 300
ORDER BY preco_medio DESC;

/* 5.3 - Investigacao: taxa de cancelamento por forma de pagamento */
SELECT
forma_pagamento,
ROUND(AVG(CASE WHEN status = 'Cancelado' THEN 1 ELSE 0 END) * 100, 2) AS taxa_cancelamento
FROM pedidos
GROUP BY forma_pagamento
ORDER BY taxa_cancelamento DESC;
