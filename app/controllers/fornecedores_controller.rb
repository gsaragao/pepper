# encoding : utf-8
class FornecedoresController < ApplicationController

  respond_to :html
  before_filter :setar_classe_menu
  before_filter :manage_params, :only => [:index]
  before_filter :load_fornecedor , :only => [:show, :edit, :update, :destroy]

  def index
    @cidades = Cidade.order(:nome)
    @fornecedor = Fornecedor.new(params[:fornecedor])
    @fornecedores = Fornecedor.pesquisar(params[:fornecedor],params[:page])
    respond_with @fornecedores
  end

  def show
    respond_with @fornecedor
  end

  def new
    load_combos
    @fornecedor = Fornecedor.new
    respond_with @fornecedor
  end

  def edit
    load_combos
  end

  def create
    @fornecedor = Fornecedor.new(params[:fornecedor])
    
    if @fornecedor.save
      flash[:notice] = t('msg.create_sucess')
      redirect_to fornecedores_path
    else
      load_combos
      render :action => :new 
    end
     
  end

  def update
    if @fornecedor.update_attributes(params[:fornecedor])
      flash[:notice] = t('msg.update_sucess')
      redirect_to fornecedores_path
    else
      load_combos
      render :action => :edit
    end
  end

  def destroy
    
    if @fornecedor.destroy
      flash[:notice] = t('msg.destroy_sucess')
    else
      flash[:alert] = @fornecedor.errors.full_messages[0]
    end

    redirect_to fornecedores_path
  end
  
  private
  
  def setar_classe_menu
    @class_fornecedor = 'active'  
  end
  
  def load_fornecedor
    begin
      @fornecedor = Fornecedor.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      flash[:alert] = t('msg.data_not_found')
      redirect_to fornecedores_path
    end
  end
  
  def load_combos 
    @cidades = Cidade.order(:nome)
  end
  
  def manage_params
    if (!params[:fornecedor].nil?) 
       params[:fornecedor].delete_if{|k,v| v.blank?}
    end
  end
  
end
