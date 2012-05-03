# encoding: UTF-8

#DestroyAll
Cliente.destroy_all
Despesa.destroy_all
Fornecedor.destroy_all
TipoDespesa.destroy_all
Compra.destroy_all
Cidade.destroy_all
Cor.destroy_all
Marca.destroy_all
Tamanho.destroy_all
Categoria.update_all(:id_pai => nil)
Categoria.destroy_all
Vendedor.destroy_all

#Cidades
@cruz = Cidade.create!( :nome => 'Cruz das Almas')
@ssa = Cidade.create!( :nome => 'Salvador')
@sp = Cidade.create!( :nome => 'São Paulo')
@saj = Cidade.create!( :nome => 'Santo Antônio de Jesus')
Cidade.create!( :nome => 'Governador Mangabeira')
Cidade.create!( :nome => 'Cachoeira')
Cidade.create!( :nome => 'São Félix')

#Cores
Cor.create!( :descricao => 'Azul')
Cor.create!( :descricao => 'Vermelho')
Cor.create!( :descricao => 'Verde')
Cor.create!( :descricao => 'Preto')
Cor.create!( :descricao => 'Branco')
Cor.create!( :descricao => 'Amarelo')

#Marcas
Marca.create!(:descricao => 'Limelight')
Marca.create!(:descricao => 'Valente')
Marca.create!(:descricao => 'TNT')
Marca.create!(:descricao => 'Raizz')
Marca.create!(:descricao => 'Vacoo')

#Tamanhos
Tamanho.create!(:descricao => 'PP')
Tamanho.create!(:descricao => 'P')
Tamanho.create!(:descricao => 'M')
Tamanho.create!(:descricao => 'G')
Tamanho.create!(:descricao => 'GG')
Tamanho.create!(:descricao => '38')
Tamanho.create!(:descricao => '40')
Tamanho.create!(:descricao => '42')
Tamanho.create!(:descricao => '44')
Tamanho.create!(:descricao => '46')

#Tipo Despesas
@tipoAli = TipoDespesa.create!(:descricao => 'Alimentação')
@tipoTrans = TipoDespesa.create!(:descricao => 'Transporte')
@tipoRoup = TipoDespesa.create!(:descricao => 'Roupas')
TipoDespesa.create!(:descricao => 'Transportadora')
TipoDespesa.create!(:descricao => 'Acessórios')
TipoDespesa.create!(:descricao => 'Calçados')
TipoDespesa.create!(:descricao => 'Impostos')

#Cliente
Cliente.create!(:nome => 'Maria Maia de Souza Mendes', :email => 'maria.maia@gmail.com', 
                :telefone => '(75) 3621-3300', :cidade_id => @cruz.id, :endereco => 'Av. Alfredo Passos, n. 10, Centro')
Cliente.create!(:nome => 'Cláudia dos Santos', :email => 'claudia.santos@bol.com', 
                :telefone => '(75) 3621-4400', :cidade_id => @cruz.id, :endereco => 'Av. Presidente Vargas, n. 234, Suzana' )
Cliente.create!(:nome => 'Ana Lúcia de Jesus', :email => 'analucia33@hotmail.com', 
                :telefone => '(75) 3621-5500', :cidade_id => @cruz.id, :endereco => 'Rua Professor José Duarte, n. 542, Poções' )
Cliente.create!(:nome => 'Manuela Souza Leite', :email => 'manuelasou.leite@ig.com.br', 
                :telefone => '(75) 3621-6600', :cidade_id => @saj.id, :endereco => 'Av. Doutor Lauro Passos, n. 98, Centro' )
Cliente.create!(:nome => 'Cássia Leal dos Reis', :email => 'cassia.leal@gmail.com', 
                :telefone => '(75) 3621-7700', :cidade_id => @saj.id, :endereco => 'Rua das Flores, bloco A, n. 102, Inocop' )
Cliente.create!(:nome => 'Roberta Matos Silva', :email => 'robertamatossilva@yahoo.com.br', 
                :telefone => '(75) 3621-8800', :cidade_id => @saj.id, :endereco => 'Av. Ribeiro Martins, n. 54, apt. 102, Ceap' )

#Fornecedores
@fortam = Fornecedor.create!(:nome => 'TAM', :email => 'contato@tam.com', 
                :telefone => '(071) 2201-1100', :cidade_id => @ssa.id, :endereco => 'Av. Dois de Julho, n. 1030, Aeroporto')
Fornecedor.create!(:nome => 'GOL', :email => 'vendas@gol.com', 
                :telefone => '(071) 4004-4422', :cidade_id => @ssa.id, :endereco => 'Av. Dois de Julho, n. 1490, Aeroporto')
@fortax = Fornecedor.create!(:nome => 'Taxi')
@formac = Fornecedor.create!(:nome => 'Mac Donalds')
@forval = Fornecedor.create!(:nome => 'Valente', :email => 'vendas@valente.com.br', 
                :telefone => '(011) 3380-1200', :cidade_id => @sp.id, :endereco => 'Shopping Mega Polo, 1o andar, n. 1002, Brás' )
@fortnt = Fornecedor.create!(:nome => 'TNT', :email => 'contato@tnt.com.br', 
                :telefone => '(011) 5570-3300', :cidade_id => @sp.id, :endereco => 'Shopping Mega Polo, 3o andar, n. 1305, Brás' )
Fornecedor.create!(:nome => 'Limelight', :email => 'vendas@limelight.com.br', 
                :telefone => '(011) 2294-5522', :cidade_id => @sp.id, :endereco => 'Shopping Mega Polo, 2o andar, n. 1204, Brás' )
Fornecedor.create!(:nome => 'Rápido 500', :email => 'contato@rapido500.com', 
                :telefone => '(011) 4455-3000', :cidade_id => @sp.id, :endereco => 'São Paulo, Centro' )

#Compras
@compra2012 = Compra.create!(:descricao => 'Maio 2012', :data => '2012-05-10', :observacao => 'Primeira compra do ano 2012')
@compra2011 = Compra.create!(:descricao => 'Janeiro 2011', :data => '2011-01-22', :observacao => 'Primeira compra do ano 2012')
Compra.create!(:descricao => 'Abril 2011', :data => '2011-04-16', :observacao => 'Segunda compra do ano 2011')
Compra.create!(:descricao => 'Setembro 2011', :data => '2011-09-18', :observacao => 'Terceira compra do ano 2011')

#Despesas
Despesa.create!(:descricao => 'Taxi SP', :compra_id => @compra2011.id, :tipo_despesa_id => @tipoTrans.id, :fornecedor_id => @fortax.id,
                :data => '2011-01-23', :valor => '23.0')
Despesa.create!(:descricao => 'Voo TAM', :compra_id => @compra2011.id, :tipo_despesa_id => @tipoTrans.id, :fornecedor_id => @fortam.id, 
                :data => '2011-01-22', :valor => '258.86')
Despesa.create!(:descricao => 'Mac Donalds', :compra_id => @compra2011.id, :tipo_despesa_id => @tipoAli.id , :fornecedor_id => @formac.id,
                :data => '2011-01-23', :valor => '14.50')
Despesa.create!(:descricao => 'Loja TNT', :compra_id => @compra2011.id, :tipo_despesa_id => @tipoRoup.id,  :fornecedor_id => @fortnt.id,
                :data => '2011-01-24', :valor => '3680.0')
Despesa.create!(:descricao => 'Loja Valente', :compra_id => @compra2011.id, :tipo_despesa_id => @tipoRoup.id, :fornecedor_id => @forval.id,
                :data => '2011-01-25', :valor => '2540.0')

#Categorias
@catblu = Categoria.create!(:descricao => 'Blusa')
Categoria.create!(:descricao => 'Manga Longa', :id_pai  => @catblu.id)
Categoria.create!(:descricao => 'Manda Boneca', :id_pai  => @catblu.id)
Categoria.create!(:descricao => 'Tomara Que Caia', :id_pai  => @catblu.id)
@catcal = Categoria.create!(:descricao => 'Calça')
Categoria.create!(:descricao => 'Jeans', :id_pai  => @catcal.id)
Categoria.create!(:descricao => 'Brim', :id_pai  => @catcal.id)
Categoria.create!(:descricao => 'Legging', :id_pai  => @catcal.id)
@catsho = Categoria.create!(:descricao => 'Short')
Categoria.create!(:descricao => 'Longo', :id_pai  => @catsho.id)
Categoria.create!(:descricao => 'Curto', :id_pai  => @catsho.id)
Categoria.create!(:descricao => 'Bermuda', :id_pai  => @catsho.id)
@catace = Categoria.create!(:descricao => 'Acessório')
Categoria.create!(:descricao => 'Oculos', :id_pai  => @catace.id)
Categoria.create!(:descricao => 'Cinto', :id_pai  => @catace.id)
Categoria.create!(:descricao => 'Colar', :id_pai  => @catace.id)
Categoria.create!(:descricao => 'Pulseira', :id_pai  => @catace.id)
@catbol = Categoria.create!(:descricao => 'Bolsa')
Categoria.create!(:descricao => 'Pequensa', :id_pai  => @catbol.id)
Categoria.create!(:descricao => 'Capanga', :id_pai  => @catbol.id)
Categoria.create!(:descricao => 'De Lado', :id_pai  => @catbol.id)
Categoria.create!(:descricao => 'Grande', :id_pai  => @catbol.id)

#Venddores

Vendedor.create!(:nome => 'Mayana Silva', :email => 'mayana.silva@gmail.com', 
                :telefone => '(75) 3625-8899', :cidade_id => @cruz.id, :endereco => 'Av. Ruy Barbosa, n. 896, Centro')
Vendedor.create!(:nome => 'Muqui', :email => 'muqui.barril@bol.com.br', 
                :telefone => '(75) 3621-6622', :cidade_id => @cruz.id, :endereco => 'Rua Madalena de Baixo, n. 35, Sapucaia' )

