# encoding : utf-8
class HomeController < ApplicationController

  respond_to :html
  before_filter :setar_classe_menu

  def index

    @compra = nil

    if params[:compra]
      load_compra(params[:compra])
    end  

    @ultimas_compras = Compra.ultimas_compras(6)
    @pagamento_despesas = PagamentoDespesa.proximos_pagamentos
    @total_pagamento_despesa = PagamentoDespesa.total_proximos_pagamentos
    @ultimos_pagamentos = PagamentoDespesa.ultimos_seis_pagamentos
    @total_ultimos_pagamentos = PagamentoDespesa.total_ultimos_pagamentos 
    @pagamento_vendas = PagamentoVenda.proximos_recebimentos
    @total_pagamento_venda = PagamentoVenda.total_proximos_recebimentos
    @ultimos_recebimentos = PagamentoVenda.ultimos_seis_recebimentos
    @total_ultimos_recebimentos = PagamentoVenda.total_ultimos_recebimentos
    @formas_pagamento = PagamentoVenda.relacao_forma_pagamento
    @total_formas = PagamentoVenda.total_pagamento
    @relacao_marcas = Marca.relacao_vendidos(@compra)
    @qtde_produtos = Produto.qtde_cadastrados_vendidos(@compra)
    @relacao_clientes = Cliente.relacao_venda(@compra)
    @relacao_pagamentos = Cliente.relacao_pagamento
    @relacao_categorias = Categoria.relacao_categoria_vendas(@compra)
    
    if @compra.nil?
       @class_geral = 'active'
    end   
  end
 
  private
  
  def setar_classe_menu
    @class_home = 'active'  
  end

  def load_compra(id)
    begin
      @compra = Compra.find(id)
    rescue ActiveRecord::RecordNotFound
      flash[:alert] = t('msg.data_not_found')
      redirect_to home_index_path
    end    
  end 

end
