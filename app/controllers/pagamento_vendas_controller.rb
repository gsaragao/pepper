# encoding : utf-8
class PagamentoVendasController < ApplicationController
  respond_to :html
  before_filter :setar_classe_menu
  before_filter :manage_params, :only => [:index]
  before_filter :load_pagamento_venda , :only => [:show, :edit, :destroy, :update]
  
  def index
    @clientes = Cliente.com_pagamento
    @pagamento_venda = PagamentoVenda.new(params[:pagamento_venda])

    if params[:cliente]
       @pagamento_venda.cliente_id = params[:cliente].to_i    
       @pagamento_venda.forma_pagamento = 0       
    end

    @pagamento_vendas = PagamentoVenda.pesquisar(@pagamento_venda,params[:page])
    respond_with @pagamento_vendas
  end
   
  def edit
    @pagamento_venda.valor_pago = @pagamento_venda.recalculo.blank? ? @pagamento_venda.valor : @pagamento_venda.recalculo
  end

  def update
    PagamentoVenda.transaction do 
      
      params[:pagamento_venda][:data_pagamento_cliente] = Date.today
      if (@pagamento_venda.forma_pagamento == PagamentoVenda::DUPLICATA)
        novo_valor = calcula_parcelas(params[:pagamento_venda][:valor_pago], @pagamento_venda.parcela, "U")
      end
      
      params[:pagamento_venda][:recalculo] = params[:pagamento_venda][:valor_pago]
      if @pagamento_venda.update_attributes(params[:pagamento_venda])
        if (@pagamento_venda.forma_pagamento == PagamentoVenda::DUPLICATA)
          if novo_valor > 0 
            PagamentoVenda.pesquisar_por_venda_duplicata(@pagamento_venda.venda_id).update_all(:recalculo => novo_valor)
          else
            PagamentoVenda.pesquisar_por_venda_duplicata(@pagamento_venda.venda_id).update_all(:recalculo => 0, :valor_pago => 0, :data_pagamento_cliente => Date.today)
          end  
        end  
        flash[:notice] = t('msg.update_sucess')
        redirect_to pagamento_vendas_path(:cliente => @pagamento_venda.venda.cliente_id)
      else
        render :action => :edit
        raise ActiveRecord::Rollback
      end
    end
  end

  def destroy
    PagamentoVenda.transaction do 
      begin
        if params[:acao] == 'desfazer'
          #novo_valor = calcula_parcelas(@pagamento_venda.valor_pago, @pagamento_venda.parcela, "D")
          #PagamentoVenda.pesquisar_por_venda_duplicata(@pagamento_venda.venda_id).update_all(:recalculo => novo_valor)
          @pagamento_venda.update_column(:valor_pago , nil)
          @pagamento_venda.update_column(:recalculo , nil)
          @pagamento_venda.update_column(:data_pagamento_cliente, nil)
        end
      rescue
        flash[:alert] = "Não foi possível realizar a operação!"
        redirect_to pagamento_vendas_path
        raise ActiveRecord::Rollback
      end  
      flash[:notice] = t('msg.update_sucess')
      redirect_to pagamento_vendas_path
    end  
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
  
  def calcula_parcelas(valor_pago, parcela_atual, operacao)

      valor_atualizado = 0
      qtde_parcelas = PagamentoVenda.qtde_parcelas_por_forma_venda(@pagamento_venda.venda_id)

      if parcela_atual < qtde_parcelas
        total_duplicata = PagamentoVenda.total_por_forma_venda(@pagamento_venda.venda_id)
        total_pago = PagamentoVenda.total_pago_forma_venda(@pagamento_venda.venda_id)
        
        if operacao == "U"
          parcelas_restantes = qtde_parcelas.to_i - parcela_atual.to_i
          valor_restante = total_duplicata.to_f - (valor_pago.to_f + total_pago.to_i)
        elsif operacao == "D"
          parcelas_restantes = (qtde_parcelas.to_i - parcela_atual.to_i) + 1 
          valor_restante = total_duplicata.to_f + valor_pago.to_f
        end

        valor_atualizado = valor_restante.to_f / parcelas_restantes.to_i
      end  
      valor_atualizado
  end

end