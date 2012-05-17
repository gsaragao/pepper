# encoding : utf-8
class DespesasController < ApplicationController

  respond_to :html
  before_filter :setar_classe_menu
  before_filter :manage_params, :only => [:index, :create, :update]
  before_filter :load_despesa , :only => [:show, :edit, :update, :destroy]

  def index
    @compras = Compra.all
    @tipo_despesas = TipoDespesa.all
    @despesa = Despesa.new(params[:despesa])
    @despesas = Despesa.pesquisar(params[:despesa],params[:page])
    respond_with @despesas
  end

  def show
    respond_with @despesa
  end

  def new
    load_combos
    @despesa = Despesa.new
    respond_with @despesa
  end

  def edit
    carrega_pagamento_despesa
    load_combos
  end

  def create
    @despesa = Despesa.new(params[:despesa])
    Despesa.transaction do

      if @despesa.save
        @despesa.parcela.to_i.times {|i|
          @pagamento = PagamentoDespesa.new
          @pagamento.despesa_id = @despesa.id
          @pagamento.forma_pagamento = @despesa.forma_pagamento
          @pagamento.parcela = i + 1
          @pagamento.valor = @despesa.valor_pagamento
          @pagamento.data = @despesa.data_pagamento + (30 * i)
          @pagamento.save
        }
    
        flash[:notice] = t('msg.create_sucess')
        redirect_to despesas_path
      else
        carrega_pagamento_despesa
        load_combos
        render :action => :new 
      end
    end     
  end

  def update
    Despesa.transaction do
      PagamentoDespesa.destroy_all(:despesa_id => @despesa.id)
      
      params[:despesa][:parcela].to_i.times {|i|
          
        @pagamento = PagamentoDespesa.new
        @pagamento.despesa_id = @despesa.id
        @pagamento.forma_pagamento = params[:despesa][:forma_pagamento]
        @pagamento.parcela = i + 1
        @pagamento.valor = params[:despesa][:valor_pagamento]
        @pagamento.data = Date.strptime(params[:despesa][:data_pagamento], '%d/%m/%Y') + (30 * i)
        @pagamento.save
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
    @compras = Compra.all
    @tipo_despesas = TipoDespesa.all
    @fornecedores = Fornecedor.all
  end
  
  def manage_params
    if (params[:despesa]) 

       #if (params[:despesa][:valor])
      #    params[:despesa][:valor] = params[:despesa][:valor].gsub('.','').gsub(',','.')
      # end

       params[:despesa].delete_if{|k,v| v.blank?}
    end
  end
  
  def carrega_pagamento_despesa
    @pagamento_last = PagamentoDespesa.where(:despesa_id => @despesa.id).last

      @despesa.forma_pagamento = @pagamento_last.forma_pagamento
      @despesa.parcela = @pagamento_last.parcela
      @despesa.valor_pagamento = @pagamento_last.valor

      @pagamento_first = PagamentoDespesa.where(:despesa_id => @despesa.id).first

      @despesa.data_pagamento = @pagamento_first.data
  end
end
