# encoding : utf-8
class ComprasController < ApplicationController

  respond_to :html, :json
  before_filter :setar_classe_menu
  before_filter :manage_params, :only => [:index]
  before_filter :load_compra , :only => [:show, :edit, :update, :destroy]

  def index
    @compra = Compra.new(params[:compra])
    @compras = Compra.pesquisar(params[:compra],params[:page])
    respond_with @compras
  end

  def show
    
    @compra.despesas.each {|desp|
      @pagamento_last = PagamentoDespesa.where(:despesa_id => desp.id).last
         desp.forma_pagamento = @pagamento_last.forma_pagamento
         desp.parcela = @pagamento_last.parcela
         desp.valor_pagamento = @pagamento_last.valor  
    }
    
    respond_with @compra
  end

  def new
    load_combos
    @compra = Compra.new
    respond_with @compra
  end

  def edit
    load_combos
  end

  def create
    @compra = Compra.new(params[:compra])
    Compra.transaction do
      valida_check_create(@compra.default)
      if @compra.save
        flash[:notice] = t('msg.create_sucess')
        redirect_to compras_path
      else
        load_combos
        render :action => :new 
      end
    end
  end

  def update
    Compra.transaction do
      valida_check_update(@compra)
      if @compra.update_attributes(params[:compra])
        flash[:notice] = t('msg.update_sucess')
        redirect_to compras_path
      else
        load_combos
        render :action => :edit
      end
    end  
  end

  def destroy
    if @compra.destroy
      flash[:notice] = t('msg.destroy_sucess')
    else
      flash[:alert] = @compra.errors.full_messages[0]
    end  
    redirect_to compras_path
  end
  
  def calcula
    compra = Compra.find(params[:compra_id])
    respond_with compra.calcula_percentual_despesa
  end
  
  private
  
  def setar_classe_menu
    @class_compra = 'active'  
  end
  
  def load_compra
    begin
      @compra = Compra.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      flash[:alert] = t('msg.data_not_found')
      redirect_to compras_path
    end    
  end
  
  def load_combos 
    #Collections
  end
  
  def manage_params
    if (!params[:compra].nil?) 
       params[:compra][:data] = trata_data(params[:compra][:data]) if params[:compra][:data]
       params[:compra].delete_if{|k,v| v.blank?}
    end
  end
  
  def valida_check_create(value)
      if (value == 1 || value == '1')  
        Compra.update_all(:default => nil)
      end 
  end
  
  def valida_check_update(compra)
    if (compra.default == 0 || compra.default == nil) 
        Compra.update_all(:default => nil)
    end 
  end
  
end
