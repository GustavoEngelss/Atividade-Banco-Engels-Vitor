/*Bloco 4.4 - Perfil do cliente */
USE ecommerce_nexashop;
select
	case
		when timestampdiff(year, data_cadastro, curdate()) < 1 then 'Novo'
        when timestampdiff(year, data_cadastro, curdate()) between 1 and 3 then 'Fiel'
        when timestampdiff(year, data_cadastro, curdate()) > 3 then 'Veterano'
	end as perfil,
    count(*) as 'Quantidade de Cliente'
from clientes
group by Perfil
order by 'Quantidade de Clientes' desc;