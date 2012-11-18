# encoding: UTF-8
class Analise


	def self.analise_estrelas
		 
		sql  = ' Select cli.nome, (ifnull(mais_trinta.valor,0) + ifnull(mais_quinze.valor,0) + ifnull(no_prazo.valor,0) + '
		sql += ' ifnull(antes.valor,0) + ifnull(carta_d.valor,0)) valor, '
		sql += ' (ifnull(mais_trinta.pontos,0) + ifnull(mais_quinze.pontos,0) + ifnull(no_prazo.pontos,0) + ifnull(antes.pontos,0) + '
		sql += ' 	ifnull(carta_d.pontos,0)) pontos '

		sql += ' 	from clientes cli '
		sql += ' 	left outer join '
		sql += ' 	(select c.id, c.nome, sum(valor) valor, ((round(sum(valor) / 100) + 1) * 0.25) pontos '
		sql += ' 	from pagamento_vendas p, vendas v, clientes c where p.venda_id = v.id and v.cliente_id = c.id '
		sql += ' 	and p.forma_pagamento in (3, 4) '
		sql += ' 	and p.data_pagamento_cliente > DATE_ADD(p.data,INTERVAL 30 DAY) '
		sql += ' 	and cliente_id not in (select distinct v.cliente_id from pagamento_vendas p, vendas v '
		sql += ' 	                       where p.venda_id = v.id and p.data_pagamento_cliente is null) group by c.id, c.nome ) mais_trinta '
		sql += ' 	on cli.id = mais_trinta.id '
		sql += ' 	left outer join '

		sql += ' 	(select c.id, c.nome, sum(valor) valor, ((round(sum(valor) / 100) + 1) * 0.5) pontos '
		sql += ' 	from pagamento_vendas p, vendas v, clientes c where p.venda_id = v.id and v.cliente_id = c.id '
		sql += ' 	and p.forma_pagamento in (3, 4) '
		sql += ' 	and p.data_pagamento_cliente between DATE_ADD(p.data,INTERVAL 15 DAY) and DATE_ADD(p.data,INTERVAL 30 DAY) '
		sql += ' 	and cliente_id not in (select distinct v.cliente_id from pagamento_vendas p, vendas v where p.venda_id = v.id '
		sql += ' 	                       and p.data_pagamento_cliente is null) group by c.id, c.nome) mais_quinze '
		sql += ' 	on cli.id = mais_quinze.id '
		sql += ' 	left outer join '

		sql += ' 	(select c.id, c.nome, sum(valor) valor, ((round(sum(valor) / 100) + 1) * 1) pontos '
		sql += ' 	from pagamento_vendas p, vendas v, clientes c where p.venda_id = v.id and v.cliente_id = c.id '
		sql += ' 	and p.forma_pagamento in (3, 4) '
		sql += ' 	and p.data_pagamento_cliente between DATE_ADD(p.data,INTERVAL 1 DAY) and DATE_ADD(p.data,INTERVAL 15 DAY) '
		sql += ' 	and cliente_id not in (select distinct v.cliente_id from pagamento_vendas p, vendas v where p.venda_id = v.id '
		sql += ' 	                       and p.data_pagamento_cliente is null) group by c.id, c.nome ) no_prazo '
		sql += ' 	on cli.id = no_prazo.id '
		sql += ' 	left outer join '

		sql += ' 	(select c.id, c.nome, sum(valor) valor, ((round(sum(valor) / 100) + 1) * 3) pontos '
		sql += ' 	from pagamento_vendas p, vendas v, clientes c where p.venda_id = v.id and v.cliente_id = c.id '
		sql += ' 	and p.forma_pagamento in (3, 4) and p.data >= p.data_pagamento_cliente '
		sql += ' 	and cliente_id not in (select distinct v.cliente_id from pagamento_vendas p, vendas v where p.venda_id = v.id '
		sql += ' 	                       and p.data_pagamento_cliente is null) group by c.id, c.nome) antes '
		sql += ' 	on cli.id = antes.id '
		sql += ' 	left outer join '

		sql += ' 	(select c.id, c.nome, sum(valor) valor, ((round(sum(valor) / 100) + 1) * 4) pontos '
		sql += ' 	from pagamento_vendas p, vendas v, clientes c '
		sql += ' 	where p.venda_id = v.id and v.cliente_id = c.id and p.forma_pagamento in (1,2) group by c.id, c.nome) carta_d '
		sql += ' 	on cli.id = carta_d.id order by 3 desc, 2 desc, 1 desc '

		Cliente.find_by_sql(sql)
	end

	def self.analise_completa
		 
		sql = ' 	Select cli.nome, (ifnull(mais_trinta.valor,0) + ifnull(mais_quinze.valor,0) + ifnull(no_prazo.valor,0) +  '
		sql += ' 	ifnull(antes.valor,0) + ifnull(carta_d.valor,0)) valor_total, '
		sql += ' 	(ifnull(mais_trinta.pontos,0) + ifnull(mais_quinze.pontos,0) + ifnull(no_prazo.pontos,0) + ifnull(antes.pontos,0) + ifnull(carta_d.pontos,0)) pontos, '
		sql += ' 	ifnull(carta_d.valor,0) cartao_dinheiro, (ifnull(mais_trinta.valor,0) + ifnull(mais_quinze.valor,0) + ifnull(no_prazo.valor,0) +  '
		sql += ' 	ifnull(antes.valor,0)) cheque_duplicata, '
		sql += ' 	(ifnull(mais_trinta.parcelas,0) + ifnull(mais_quinze.parcelas,0) + ifnull(no_prazo.parcelas,0) +  '
		sql += ' 	ifnull(antes.parcelas,0) + ifnull(carta_d.parcelas,0)) parcelas_total, ifnull(carta_d.parcelas,0) parcelas_cartao_dinheiro, '
		sql += ' 	ifnull(antes.parcelas,0) antes, ifnull(no_prazo.parcelas,0) no_prazo, ifnull(mais_quinze.parcelas,0) quinze, ifnull(mais_trinta.parcelas,0) trinta '

		sql += ' 	from clientes cli '
		sql += ' 	left outer join '
		sql += ' 	(select c.id, c.nome, sum(valor) valor, ((round(sum(valor) / 100) + 1) * 0.25) pontos, count(*) parcelas '
		sql += ' 	from pagamento_vendas p, vendas v, clientes c where p.venda_id = v.id and v.cliente_id = c.id '
		sql += ' 	and p.forma_pagamento in (3, 4) '
		sql += ' 	and p.data_pagamento_cliente > DATE_ADD(p.data,INTERVAL 30 DAY) '
		sql += ' 	and cliente_id not in (select distinct v.cliente_id from pagamento_vendas p, vendas v '
		sql += ' 	                       where p.venda_id = v.id and p.data_pagamento_cliente is null) group by c.id, c.nome ) mais_trinta '
		sql += ' 	on cli.id = mais_trinta.id '
		sql += ' 	left outer join '

		sql += ' 	(select c.id, c.nome, sum(valor) valor, ((round(sum(valor) / 100) + 1) * 0.5) pontos, count(*) parcelas '
		sql += ' 	from pagamento_vendas p, vendas v, clientes c where p.venda_id = v.id and v.cliente_id = c.id '
		sql += ' 	and p.forma_pagamento in (3, 4) '
		sql += ' 	and p.data_pagamento_cliente between DATE_ADD(p.data,INTERVAL 15 DAY) and DATE_ADD(p.data,INTERVAL 30 DAY) '
		sql += ' 	and cliente_id not in (select distinct v.cliente_id from pagamento_vendas p, vendas v where p.venda_id = v.id '
		sql += ' 	                       and p.data_pagamento_cliente is null) group by c.id, c.nome) mais_quinze '
		sql += ' 	on cli.id = mais_quinze.id '
		sql += ' 	left outer join '

		sql += ' 	(select c.id, c.nome, sum(valor) valor, ((round(sum(valor) / 100) + 1) * 1) pontos, count(*) parcelas '
		sql += ' 	from pagamento_vendas p, vendas v, clientes c where p.venda_id = v.id and v.cliente_id = c.id '
		sql += ' 	and p.forma_pagamento in (3, 4) '
		sql += ' 	and p.data_pagamento_cliente between DATE_ADD(p.data,INTERVAL 1 DAY) and DATE_ADD(p.data,INTERVAL 15 DAY) '
		sql += ' 	and cliente_id not in (select distinct v.cliente_id from pagamento_vendas p, vendas v where p.venda_id = v.id '
		sql += ' 	                       and p.data_pagamento_cliente is null) group by c.id, c.nome ) no_prazo '
		sql += ' 	on cli.id = no_prazo.id '
		sql += ' 	left outer join '

		sql += ' 	(select c.id, c.nome, sum(valor) valor, ((round(sum(valor) / 100) + 1) * 3) pontos, count(*) parcelas '
		sql += ' 	from pagamento_vendas p, vendas v, clientes c where p.venda_id = v.id and v.cliente_id = c.id '
		sql += ' 	and p.forma_pagamento in (3, 4) and p.data >= p.data_pagamento_cliente '
		sql += ' 	and cliente_id not in (select distinct v.cliente_id from pagamento_vendas p, vendas v where p.venda_id = v.id '
		sql += ' 	                       and p.data_pagamento_cliente is null) group by c.id, c.nome) antes '
		sql += ' 	on cli.id = antes.id '
		sql += ' 	left outer join '

		sql += ' 	(select c.id, c.nome, sum(valor) valor, ((round(sum(valor) / 100) + 1) * 4) pontos, count(*) parcelas '
		sql += ' 	from pagamento_vendas p, vendas v, clientes c '
		sql += ' 	where p.venda_id = v.id and v.cliente_id = c.id and p.forma_pagamento in (1,2) group by c.id, c.nome) carta_d '
		sql += ' 	on cli.id = carta_d.id order by 3 desc, 2 desc, 1 desc '

		Cliente.find_by_sql(sql)
	end

end	