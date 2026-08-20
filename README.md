# Atividade de Consultas SQL - NexaShop

Este repositorio guarda a nossa atividade de banco de dados da faculdade.

O trabalho foi feito com um banco de dados de uma loja online ficticia chamada
**NexaShop**. A ideia era treinar consultas em SQL (SELECT, filtros, agrupamentos
e o comando CASE) usando so uma tabela por vez, sem JOIN.

## Quem fez

- Vitor Cesar da Silva
- Gustavo Engels

## O que tem em cada pasta

- **consultas_nexashop.sql** - arquivo principal, com todas as consultas juntas,
  numeradas e comentadas na ordem dos blocos.
- **ecommerce_nexashop.sql** - o banco de dados da atividade (para importar no MySQL).
- **comandos/** - as consultas separadas em arquivos por bloco, uma tarefa por arquivo.
- **resultados-pdf/** - o resultado de cada consulta salvo em PDF (so a tabela de resultado).
- **Docs/** - o relatorio final da atividade em Word (.docx).

## Como usar

1. Abrir o XAMPP e ligar o MySQL.
2. Importar o arquivo `ecommerce_nexashop.sql` (isso cria o banco e as tabelas).
3. Abrir o arquivo `consultas_nexashop.sql` e rodar as consultas.

## Sobre o banco

O banco tem 4 tabelas:

- **clientes** - dados dos clientes da loja.
- **produtos** - o catalogo de produtos.
- **pedidos** - os pedidos feitos na loja.
- **avaliacoes** - as notas que os clientes deram.
