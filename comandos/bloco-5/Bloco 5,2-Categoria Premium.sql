/*Bloco 5.2 - Categorias Premium*/
USE ecommerce_nexashop;
select
	categoria,
    count(*) as 'Quantidade de Produtos',
    round(avg(preco), 2) as 'Preço Médio (R$)'
from produtos 
where Ativo = '1'
group by categoria
having avg(preco) > 300
order by 'Preço Médio (R$)' desc;