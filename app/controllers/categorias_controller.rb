# encoding : utf-8
class CategoriasController < ApplicationController

  respond_to :html, :json
  before_filter :setar_classe_menu
  before_filter :manage_params, :only => [:index]
  before_filter :load_categoria , :only => [:show, :edit, :update, :destroy]

  def index 
    @categoria = Categoria.new(params[:categoria])
    @categorias = Categoria.pesquisar(params[:categoria],params[:page])
    respond_with @categorias
  end
  
  def auto
    
    if (Rails.cache.read(:categorias)) 
      @categorias = Rails.cache.read(:categorias)  
    else
      @categorias = Categoria.all
      Rails.cache.write(:categorias ,@categorias)
    end
      
    list = [] 
    @categorias.map {|u| 
      nome_completo = u.rec
      if (nome_completo.downcase.include?(params[:term].downcase))  
        list <<  {id: u.id, label: nome_completo}  
      end    
    }   

    respond_with list
  end
  
  def show
    respond_with @categoria
  end

  def new
    load_combos
    @categoria = Categoria.new
    respond_with @categoria
  end

  def edit
    load_combos
  end

  def create
    @categoria = Categoria.new(params[:categoria])
    
    if @categoria.save
      Rails.cache.delete(:categorias)
      flash[:notice] = t('msg.create_sucess')
      redirect_to categorias_path
    else
      load_combos
      render :action => :new 
    end
     
  end

  def update
    if @categoria.update_attributes(params[:categoria])
      flash[:notice] = t('msg.update_sucess')
      Rails.cache.delete(:categorias)
      redirect_to categorias_path
    else
      load_combos
      render :action => :edit
    end
  end

  def destroy
    if @categoria.destroy
      Rails.cache.delete(:categorias)
      flash[:notice] = t('msg.destroy_sucess')
    else
      flash[:alert] = @categoria.errors.full_messages[0]
    end  
    redirect_to categorias_path
  end
  
  private
  
  def setar_classe_menu
    @class_categoria = 'active'  
  end
  
  def load_categoria
    begin
      @categoria = Categoria.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      flash[:alert] = t('msg.data_not_found')
      redirect_to categorias_path
    end    
  end
  
  def load_combos 
    #Collections
  end
  
  def manage_params
    if (!params[:categoria].nil?) 
       params[:categoria].delete_if{|k,v| v.blank?}
    end
  end
  
end
