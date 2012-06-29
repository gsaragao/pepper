# encoding : utf-8
class MarcasController < ApplicationController

  respond_to :html
  before_filter :setar_classe_menu
  before_filter :manage_params, :only => [:index]
  before_filter :load_marca , :only => [:show, :edit, :update, :destroy]

  def index
    @marca = Marca.new(params[:marca])
    @marcas = Marca.pesquisar(params[:marca],params[:page])
    respond_with @marcas
  end

  def show
    respond_with @marca
  end

  def new
    load_combos
    @marca = Marca.new
    respond_with @marca
  end

  def edit
    load_combos
  end

  def create
    @marca = Marca.new(params[:marca])
    
    if @marca.save
      flash[:notice] = t('msg.create_sucess')
      redirect_to marcas_path
    else
      load_combos
      render :action => :new 
    end
     
  end

  def update
    if @marca.update_attributes(params[:marca])
      flash[:notice] = t('msg.update_sucess')
      redirect_to marcas_path
    else
      load_combos
      render :action => :edit
    end
  end

  def destroy
    if @marca.destroy
      flash[:notice] = t('msg.destroy_sucess')
    else
      flash[:alert] = @marca.errors.full_messages[0]
    end    
    redirect_to marcas_path
  end
  
  private
  
  def setar_classe_menu
    @class_marca = 'active'  
  end
  
  def load_marca
    begin
      @marca = Marca.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      flash[:alert] = t('msg.data_not_found')
      redirect_to marcas_path
    end    
    
  end
  
  def load_combos 
    #Collections
  end
  
  def manage_params
    if (!params[:marca].nil?) 
       params[:marca].delete_if{|k,v| v.blank?}
    end
  end
  
end
