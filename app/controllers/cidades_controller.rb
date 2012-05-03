# encoding : utf-8
class CidadesController < ApplicationController

  respond_to :html
  before_filter :setar_classe_menu
  before_filter :manage_params, :only => [:index]
  before_filter :load_cidade , :only => [:show, :edit, :update, :destroy]

  def index
    @cidade = Cidade.new(params[:cidade])
    @cidades = Cidade.pesquisar(params[:cidade],params[:page])
    respond_with @cidades
  end

  def show
    respond_with @cidade
  end

  def new
    load_combos
    @cidade = Cidade.new
    respond_with @cidade
  end

  def edit
    load_combos
  end

  def create
    @cidade = Cidade.new(params[:cidade])
    
    if @cidade.save
      flash[:notice] = t('msg.create_sucess')
      redirect_to cidades_path
    else
      load_combos
      render :action => :new 
    end
     
  end

  def update
    if @cidade.update_attributes(params[:cidade])
      flash[:notice] = t('msg.update_sucess')
      redirect_to cidades_path
    else
      load_combos
      render :action => :edit
    end
  end

  def destroy
    
    if @cidade.destroy
      flash[:notice] = t('msg.destroy_sucess')
    else
      flash[:alert] = @cidade.errors.full_messages[0]
    end

    redirect_to cidades_path
  end
  
  private
  
  def setar_classe_menu
    @class_cidade = 'active'  
  end
  
  def load_cidade
    begin
      @cidade = Cidade.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      flash[:alert] = t('msg.data_not_found')
      redirect_to cidades_path
    end
  end
  
  def load_combos 
    #Collections
  end
  
  def manage_params
    if (!params[:cidade].nil?) 
       params[:cidade].delete_if{|k,v| v.blank?}
    end
  end
  
end
