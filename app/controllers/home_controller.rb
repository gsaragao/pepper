# encoding : utf-8
class HomeController < ApplicationController

  respond_to :html
  before_filter :setar_classe_menu

  def index
    @pagamento_despesas = PagamentoDespesa.proximos_seis_meses
    @total_pagamento_despesa = PagamentoDespesa.total_proximos_seis_meses
    @pagamento_vendas = PagamentoVenda.proximos_seis_meses
    @total_pagamento_venda = PagamentoVenda.total_proximos_seis_meses
    @formas_pagamento = PagamentoVenda.relacao_forma_pagamento
    @total_formas = PagamentoVenda.total_pagamento
    @relacao_marcas = Marca.relacao_vendidos
    @qtde_produtos = Produto.qtde_cadastrados_vendidos
    @relacao_clientes = Cliente.relacao_venda
    @relacao_pagamentos = Cliente.relacao_pagamento
    @relacao_categorias = Categoria.relacao_categoria_vendas
  end
 
  private
  
  def setar_classe_menu
    @class_home = 'active'  
  end

end
