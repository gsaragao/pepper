# encoding : utf-8
class PagamentoVendasController < ApplicationController
  respond_to :html
  before_filter :setar_classe_menu
  before_filter :manage_params, :only => [:index]
  before_filter :load_pagamento_venda , :only => [:show, :destroy]
  
  def index
    @clientes = Cliente.order(:nome)
    @pagamento_venda = PagamentoVenda.new(params[:pagamento_venda])
    @pagamento_vendas = PagamentoVenda.pesquisar(params[:pagamento_venda],params[:page])
    respond_with @pagamento_vendas
  end
  
  def destroy
    
    if params[:acao] == 'pagar'
      @pagamento_venda.update_attribute(:data_pagamento_cliente, Date.today)
    elsif params[:acao] == 'desfazer'
      @pagamento_venda.update_attribute(:data_pagamento_cliente, nil)
    end
    
    flash[:notice] = t('msg.update_sucess')
    redirect_to pagamento_vendas_path
  end 
  
  private
  
  def setar_classe_menu
    @class_pagamento_venda = 'active'  
  end
  
  def load_pagamento_venda
    begin
      @pagamento_venda = PagamentoVenda.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      flash[:alert] = t('msg.data_not_found')
      redirect_to pagamento_vendas_path
    end    
  end
  
  def manage_params
    if (!params[:pagamento_venda].nil?) 
       params[:pagamento_venda].delete_if{|k,v| v.blank?}
    end
  end
  
end