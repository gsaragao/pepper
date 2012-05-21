# encoding : utf-8
class DespesasController < ApplicationController

  respond_to :html
  before_filter :setar_classe_menu
  before_filter :manage_params, :only => [:index, :create, :update]
  before_filter :load_despesa , :only => [:show, :edit, :update, :destroy]

  def index
    @compras = Compra.order(:data)
    @tipo_despesas = TipoDespesa.order(:descricao)
    @despesa = Despesa.new(params[:despesa])
    @despesas = Despesa.pesquisar(params[:despesa],params[:page])
    respond_with @despesas
  end

  def show
    respond_with @despesa
  end

  def new
    load_combos
    @compra_default = Compra.find_by_default(1)
    @despesa = Despesa.new
    @despesa.compra_id = @compra_default.id if @compra_default
    respond_with @despesa
  end

  def edit
    carrega_pagamento_despesa

    if (!params[:acao].nil? && params[:acao] == Despesa::COPY)
      @despesa = @despesa.dup
      @despesa.descricao = nil
      @despesa.valor = nil
      @despesa.acao = Despesa::COPY
    end
    load_combos
  end

  def create
    @despesa = Despesa.new(params[:despesa])
    Despesa.transaction do

      if @despesa.save
        
        data = Date.strptime(@despesa.data_pagamento)
        
        @despesa.parcela.to_i.times {|i|
          @pagamento = PagamentoDespesa.new
          @pagamento.despesa_id = @despesa.id
          @pagamento.forma_pagamento = @despesa.forma_pagamento
          @pagamento.parcela = i + 1
          @pagamento.valor = @despesa.valor_pagamento
          @pagamento.data = data
          @pagamento.save
          data += 1.month
        }
    
        flash[:notice] = t('msg.create_sucess')
        redirect_to despesas_path
      else
        load_combos
        render :action => :new 
      end
    end     
  end

  def update
    Despesa.transaction do
      PagamentoDespesa.destroy_all(:despesa_id => @despesa.id)
      
      data = Date.strptime(params[:despesa][:data_pagamento])
      
      params[:despesa][:parcela].to_i.times {|i|
          
        @pagamento = PagamentoDespesa.new
        @pagamento.despesa_id = @despesa.id
        @pagamento.forma_pagamento = params[:despesa][:forma_pagamento]
        @pagamento.parcela = i + 1
        @pagamento.valor = params[:despesa][:valor_pagamento]
        @pagamento.data = data
        @pagamento.save
        
        data += 1.month
      }
      
      if @despesa.update_attributes(params[:despesa])
        flash[:notice] = t('msg.update_sucess')
        redirect_to despesas_path
      else
        carrega_pagamento_despesa
        load_combos
        render :action => :edit
      end
    end  
  end

  def destroy
    @despesa.destroy
    flash[:notice] = t('msg.destroy_sucess')
    redirect_to despesas_path
  end
  
  private
  
  def setar_classe_menu
    @class_despesa = 'active'  
  end
  
  def load_despesa
    begin
      @despesa = Despesa.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      flash[:alert] = t('msg.data_not_found')
      redirect_to despesas_path
    end
  end
  
  def load_combos 
    @compras = Compra.order(:data)
    @tipo_despesas = TipoDespesa.order(:descricao)
    @fornecedores = Fornecedor.order(:nome)
  end
  
  def manage_params
    if (!params[:despesa].nil?) 

       #if (params[:despesa][:valor])
      #    params[:despesa][:valor] = params[:despesa][:valor].gsub('.','').gsub(',','.')
      # end
       params[:despesa][:data] = trata_data(params[:despesa][:data]) if params[:despesa][:data]
       params[:despesa][:data_pagamento] = trata_data(params[:despesa][:data_pagamento]) if params[:despesa][:data_pagamento]
       params[:despesa].delete_if{|k,v| v.blank?}
    end
  end
  
  def carrega_pagamento_despesa
    @pagamento_first = PagamentoDespesa.where(:despesa_id => @despesa.id).first
    @pagamento_last = PagamentoDespesa.where(:despesa_id => @despesa.id).last
    
    if @pagamento_first && @pagamento_last     
      @despesa.forma_pagamento = @pagamento_last.forma_pagamento
      @despesa.parcela = @pagamento_last.parcela
      @despesa.valor_pagamento = @pagamento_last.valor
      @despesa.data_pagamento = @pagamento_first.data
    end
  end
end
