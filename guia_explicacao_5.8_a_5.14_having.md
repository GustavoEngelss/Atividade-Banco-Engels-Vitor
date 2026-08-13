# Guia de Apoio à Explicação — Itens 5.8 a 5.14
### De IN/BETWEEN/NULL até HAVING

> Este documento complementa o roteiro oficial. Ele não substitui as demonstrações já prontas — traz **analogias, falas extras, armadilhas comuns e perguntas de verificação** para você usar durante a explicação em sala.

---

## 5.8 — IN, BETWEEN, IS NULL e IS NOT NULL
**Tempo sugerido: 15 min**

### Como abrir o assunto
Antes de mostrar sintaxe, escreva no quadro/projetor esta consulta com múltiplos `OR`:
```sql
SELECT nome, estado
FROM alunos
WHERE estado = 'SC' OR estado = 'PR' OR estado = 'RS' OR estado = 'SP';
```
Pergunte: *"Isso funciona, mas o que acontece se eu precisar comparar com 10 estados?"* — deixe a turma sentir o problema antes de apresentar a solução.

### Analogias úteis
- **IN** = "está numa lista de convidados". Ou o valor está na lista, ou não está — não importa a ordem.
- **BETWEEN** = "está dentro de uma faixa de preço" — como filtro de e-commerce (de R$50 a R$150).
- **IS NULL** = "campo em branco no formulário" — não é zero, não é vazio, é *ausência de resposta*.

### Exemplo extra (além do já demonstrado)
```sql
-- NOT IN: o oposto de IN
SELECT nome, estado
FROM alunos
WHERE estado NOT IN ('SC', 'PR', 'RS');

-- NOT BETWEEN
SELECT matricula_id, media_final
FROM notas
WHERE media_final NOT BETWEEN 7 AND 10;
```

### Armadilha clássica para expor em sala
Pergunte: *"O que essa consulta retorna?"*
```sql
SELECT nome, telefone FROM alunos WHERE telefone = NULL;
```
Resposta: **nada**, mesmo que existam telefones nulos — porque `= NULL` nunca é verdadeiro em SQL. É o gancho perfeito para reforçar `IS NULL` / `IS NOT NULL`.

### Pergunta de verificação
*"Por que BETWEEN 7 AND 10 inclui o 7 e o 10, mas NOT BETWEEN 7 AND 10 exclui os dois?"*

---

## 5.9 — ORDER BY
**Tempo sugerido: 8 min**

### Como abrir o assunto
Rode duas vezes a mesma consulta sem `ORDER BY` (se possível, em conexões diferentes ou após pequenas alterações) e pergunte se a ordem das linhas é garantida. Ideia central: **sem ORDER BY, a ordem é um "acidente" de como o banco armazenou os dados, não uma garantia.**

### Analogia útil
ORDER BY é como organizar uma lista de chamada — por nome (alfabética), por nota (ranking) ou por múltiplos critérios (primeiro por turma, depois por nome).

### Exemplo extra
```sql
-- Ranking: as 5 maiores médias registradas
SELECT matricula_id, media_final
FROM notas
ORDER BY media_final DESC
LIMIT 5;
```

### Armadilha comum
`ORDER BY` com múltiplas colunas: mostrar que a **ordem das colunas importa**.
```sql
SELECT nome, estado, cidade FROM alunos ORDER BY estado, cidade;
-- é diferente de
SELECT nome, estado, cidade FROM alunos ORDER BY cidade, estado;
```

### Pergunta de verificação
*"Se eu ordenar por estado e depois por cidade, dentro de um mesmo estado as cidades ficam em ordem alfabética?"*

---

## 5.10 — DISTINCT
**Tempo sugerido: 8 min**

### Como abrir o assunto
Rode primeiro sem DISTINCT:
```sql
SELECT estado FROM alunos ORDER BY estado;
```
Deixe a turma perceber a repetição visual do mesmo estado várias vezes. Só depois mostre o DISTINCT como solução.

### Analogia útil
DISTINCT é como pedir "quais sabores de sorvete essa loja tem?" — você não quer saber quantos potes de cada sabor existem, só **quais sabores existem**.

### Armadilha comum (a mais importante do tópico)
```sql
SELECT DISTINCT estado FROM alunos;
-- diferente de
SELECT DISTINCT estado, cidade FROM alunos;
```
No segundo caso, DISTINCT considera a **combinação** das duas colunas — então o mesmo estado pode aparecer várias vezes se estiver associado a cidades diferentes.

### Pergunta de verificação
*"DISTINCT elimina linhas duplicadas inteiras ou só duplicadas nas colunas que eu selecionei?"*

---

## 5.11 — LIMIT e OFFSET
**Tempo sugerido: 8 min**

### Como abrir o assunto
Pergunte: *"Quando vocês usam um app e veem 'página 2 de resultados', como vocês acham que isso é feito no banco de dados?"* — LIMIT/OFFSET é a resposta técnica para paginação.

### Analogia útil
- **LIMIT** = "eu quero só os 20 primeiros da fila".
- **OFFSET** = "pule os primeiros 40 e me mostre a partir daí".

### Fórmula para o quadro
```
OFFSET = (número_da_página − 1) × registros_por_página
```
Exemplo: página 3, 20 registros por página → OFFSET = (3-1) × 20 = 40.

### Exemplo extra
```sql
-- Top 3 piores médias (uso combinado com ORDER BY)
SELECT matricula_id, media_final
FROM notas
ORDER BY media_final ASC
LIMIT 3;
```

### Armadilha comum
Reforce: **LIMIT sem ORDER BY é perigoso** — "os 20 primeiros" de uma ordem não garantida não significa nada de útil.

### Pergunta de verificação
*"Por que sempre devemos usar ORDER BY junto com LIMIT em uma tela paginada?"*

---

## 5.12 — Funções agregadoras
**Tempo sugerido: 12 min**

### Como abrir o assunto
Escreva no quadro a pergunta de negócio antes do SQL: *"Qual é a média geral de notas da instituição?"* — e só depois mostre que isso vira uma linha de código.

### Analogia útil
Funções agregadoras são como um resumo de boletim escolar: em vez de listar todas as notas de todas as provas, você quer **um número que resuma tudo**.

### Tabela-resumo para deixar visível durante a explicação
| Função | O que faz | Exemplo de uso |
|---|---|---|
| COUNT | Conta linhas (ou valores não nulos) | Quantos alunos? |
| SUM | Soma valores | Total de matrículas ativas |
| AVG | Calcula média | Média geral de notas |
| MIN | Menor valor | Pior nota da turma |
| MAX | Maior valor | Melhor nota da turma |

### Armadilha comum (a mais importante do tópico)
```sql
SELECT COUNT(*) FROM alunos;
-- diferente de
SELECT COUNT(telefone) FROM alunos;
```
`COUNT(*)` conta **linhas**. `COUNT(coluna)` conta **valores não nulos** daquela coluna. Peça que a turma preveja qual número será maior ou igual ao outro, e por quê.

### Pergunta de verificação
*"Se eu rodar SELECT AVG(media_final), matricula_id FROM notas; (sem GROUP BY), o que vai acontecer?"* — resposta: **erro** (ou comportamento inconsistente), porque mistura agregado com coluna não agregada — gancho perfeito para o próximo tópico (GROUP BY).

---

## 5.13 — GROUP BY



*"Eu quero a média de notas, mas separada por situação final (aprovado/reprovado). Como faço isso?"*

### Analogia útil
GROUP BY é como separar uma pilha de provas em montinhos por turma **antes** de calcular a média de cada montinho.


1. Comece só com o agrupamento, sem agregação:
   ```sql
   SELECT estado FROM alunos GROUP BY estado;
   ```
   (Mostre que sozinho isso parece só um DISTINCT.)
2. Acrescente a métrica:
   ```sql
   SELECT estado, COUNT(*) AS total_alunos
   FROM alunos
   GROUP BY estado;
   ```
3. Ordene para virar relatório de verdade:
   ```sql
   SELECT estado, COUNT(*) AS total_alunos
   FROM alunos
   GROUP BY estado
   ORDER BY total_alunos DESC;
   ```

### Regra de OURO 
> "Toda coluna no SELECT que **não** está dentro de uma função agregadora precisa estar no GROUP BY."

### Armadilha comum
```sql
SELECT estado, cidade, COUNT(*) FROM alunos GROUP BY estado;
```
 *"Isso vai dar erro ou resultado estranho? Por quê?"* `cidade` não está agregada nem no GROUP BY.


---

## 5.14 — HAVING

 *"Como eu filtro só os estados que têm mais de 300 alunos?"* 
```sql
SELECT estado, COUNT(*) AS total_alunos
FROM alunos
WHERE COUNT(*) > 300   -- ERRO proposital
GROUP BY estado;
```
 **WHERE não enxerga agregações, porque WHERE roda antes do agrupamento.**


- **WHERE** filtra pessoas *antes* de formar os montinhos (grupos).
- **HAVING** filtra os *montinhos já prontos*, depois de calculados.

### Linha do tempo de execução para desenhar no quadro
```
FROM  →  WHERE  →  GROUP BY  →  HAVING  →  SELECT  →  ORDER BY
```
Isso explica de uma vez por que WHERE não pode usar COUNT/AVG e HAVING pode.

### Exemplo extra combinando WHERE + GROUP BY + HAVING
```sql
-- Só alunos ativos, agrupados por estado, só estados com mais de 50 ativos
SELECT estado, COUNT(*) AS total_ativos
FROM alunos
WHERE status = 'Ativo'
GROUP BY estado
HAVING COUNT(*) > 50
ORDER BY total_ativos DESC;
```
Ótimo exemplo para mostrar que **WHERE e HAVING podem coexistir na mesma consulta**, cada um filtrando em seu momento.

### Armadilha comum
```sql
SELECT situacao_final, AVG(media_final) AS media
FROM notas
GROUP BY situacao_final
HAVING media_final >= 7;   -- ERRO: usar a coluna original, não o agregado
```
Correção:
```sql
HAVING AVG(media_final) >= 7;
```
(Observação técnica: no MySQL, muitas vezes `HAVING media >= 7` usando o **alias** funciona)

---
---

## 5.15 — CASE


### Como abrir o assunto
Explique que o `CASE` é uma estrutura condicional dentro do SQL, semelhante ao `if-else` em linguagens de programação. Ele é usado para criar colunas calculadas ou para modificar os resultados com base em condições.

### Exemplo básico
Mostre um exemplo simples de uso do `CASE` para classificar alunos com base na nota final:

```sql
SELECT matricula_id, 
       media_final,
       CASE 
           WHEN media_final >= 7 THEN 'Aprovado'
           WHEN media_final >= 5 THEN 'Recuperação'
           ELSE 'Reprovado'
       END AS situacao
FROM notas;

```

Resultado esperado: A consulta retorna uma nova coluna chamada situacao, que classifica os alunos como "Aprovado", "Recuperação" ou "Reprovado" com base na nota final.

Exemplo com múltiplas condições
Mostre como o CASE pode ser usado com múltiplas condições para categorizar os alunos por faixa de nota:

```sql
SELECT matricula_id, 
       media_final,
       CASE 
           WHEN media_final >= 9 THEN 'Excelente'
           WHEN media_final >= 7 THEN 'Bom'
           WHEN media_final >= 5 THEN 'Regular'
           ELSE 'Insuficiente'
       END AS desempenho
FROM notas;
```

##### Resultado esperado: A consulta retorna uma nova coluna chamada desempenho, que classifica os alunos em categorias mais detalhadas.

# Exemplo com cálculo 
 Por exemplo, calcular um bônus para os alunos com base na nota final:

```sql
SELECT matricula_id, 
       media_final,
       CASE 
           WHEN media_final >= 9 THEN media_final * 1.2
           WHEN media_final >= 7 THEN media_final * 1.1
           ELSE media_final
       END AS nota_com_bonus
FROM notas;
```
Resultado esperado: A consulta retorna uma nova coluna chamada nota_com_bonus, que aplica um bônus de 20% para notas acima de 9 e 10% para notas entre 7 e 9.


## Quadro-resumo para fechar o bloco (5.8 a 5.14)

| Tópico | Pergunta de negócio que resolve |
|---|---|
| IN / BETWEEN / NULL | "Está numa lista? Está numa faixa? Está em branco?" |
| ORDER BY | "Em que ordem eu quero ver o resultado?" |
| DISTINCT | "Quais valores únicos existem?" |
| LIMIT / OFFSET | "Quero só uma parte do resultado (paginação)." |
| Agregadoras | "Qual é o resumo (total, média, mínimo, máximo)?" |
| GROUP BY | "Resumo, mas separado por categoria." |
| HAVING | "Filtrar as categorias depois de calculadas." |
| CASE | "Resumindo IF e Else" |


