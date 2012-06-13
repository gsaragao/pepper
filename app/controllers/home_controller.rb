# encoding : utf-8
class HomeController < ApplicationController

  respond_to :html
  before_filter :setar_classe_menu

  def index
    @pagamento_despesas = PagamentoDespesa.proximos_seis_meses
    @total_pagamento_despesa = PagamentoDespesa.total_proximos_seis_meses
    @pagamento_vendas = PagamentoVenda.proximos_seis_meses
    @total_pagamento_venda = PagamentoVenda.total_proximos_seis_meses
  end
 
  private
  
  def setar_classe_menu
    @class_home = 'active'  
  end

end
