# encoding : utf-8
class TipoDespesasController < ApplicationController

  respond_to :html
  before_filter :setar_classe_menu
  before_filter :manage_params, :only => [:index]
  before_filter :load_tipo_despesa , :only => [:show, :edit, :update, :destroy]

  def index
    @tipo_despesa = TipoDespesa.new(params[:tipo_despesa])
    @tipo_despesas = TipoDespesa.pesquisar(params[:tipo_despesa],params[:page])
    respond_with @tipo_despesas
  end

  def show
    respond_with @tipo_despesa
  end

  def new
    load_combos
    @tipo_despesa = TipoDespesa.new
    respond_with @tipo_despesa
  end

  def edit
    load_combos
  end

  def create
    @tipo_despesa = TipoDespesa.new(params[:tipo_despesa])
    
    if @tipo_despesa.save
      flash[:notice] = t('msg.create_sucess')
      redirect_to tipo_despesas_path
    else
      load_combos
      render :action => :new 
    end
     
  end

  def update
    if @tipo_despesa.update_attributes(params[:tipo_despesa])
      flash[:notice] = t('msg.update_sucess')
      redirect_to tipo_despesas_path
    else
      load_combos
      render :action => :edit
    end
  end

  def destroy
    if @tipo_despesa.destroy
      Rails.cache.delete(:categorias)
      flash[:notice] = t('msg.destroy_sucess')
    else
      flash[:alert] = @tipo_despesa.errors.full_messages[0]
    end  
    redirect_to tipo_despesas_path
  end
  
  private
  
  def setar_classe_menu
    @class_tipo_despesa = 'active'  
  end
  
  def load_tipo_despesa
    begin
      @tipo_despesa = TipoDespesa.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      flash[:alert] = t('msg.data_not_found')
      redirect_to tipo_despesas_path
    end    
    
  end
  
  def load_combos 
    #Collections
  end
  
  def manage_params
    if (!params[:tipo_despesa].nil?) 
       params[:tipo_despesa].delete_if{|k,v| v.blank?}
    end
  end
  
end
