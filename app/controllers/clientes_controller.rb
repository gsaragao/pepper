# encoding : utf-8
class ClientesController < ApplicationController

  respond_to :html, :json
  before_filter :setar_classe_menu
  before_filter :manage_params, :only => [:index]
  before_filter :load_cliente , :only => [:show, :edit, :update, :destroy]
  
  def index
    @cidades = Cidade.order(:nome)
    @cliente = Cliente.new(params[:cliente])
    @clientes = Cliente.pesquisar(params[:cliente],params[:page])
    respond_with @clientes
  end

  def show
    respond_with @cliente
  end

  def new
    load_combos
    @cliente = Cliente.new
    respond_with @cliente
  end

  def auto

    if (Rails.cache.read(:clientes)) 
      @clientes = Rails.cache.read(:clientes)  
    else
      @clientes = Cliente.order(:nome)
      Rails.cache.write(:clientes ,@clientes)
    end
      
    list = [] 
    @clientes.map {|c| 
      if (c.nome.downcase.include?(params[:term].downcase)) 
        list <<  {id: c.id, label: c.nome}  
      end    
    }   

    respond_with list
  end

  def edit
    load_combos
  end

  def create
    @cliente = Cliente.new(params[:cliente])
    
    if @cliente.save
      Rails.cache.delete(:clientes)
      flash[:notice] = t('msg.create_sucess')
      redirect_to clientes_path
    else
      load_combos
      render :action => :new 
    end
     
  end

  def update
    if @cliente.update_attributes(params[:cliente])
      Rails.cache.delete(:clientes)
      flash[:notice] = t('msg.update_sucess')
      #ClienteMailer.enviar(@cliente).deliver
      redirect_to clientes_path
    else
      load_combos
      render :action => :edit
    end
  end

  def destroy
    if @cliente.destroy
      Rails.cache.delete(:clientes)
      flash[:notice] = t('msg.destroy_sucess')
    else
      flash[:alert] = @cliente.errors.full_messages[0]
    end
        
    redirect_to clientes_path
  end
  
  private
  
  def setar_classe_menu
    @class_cliente = 'active'  
  end
  
  def load_cliente
    begin
      @cliente = Cliente.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      flash[:alert] = t('msg.data_not_found')
      redirect_to clientes_path
    end    
  end
  
  def load_combos 
    @cidades = Cidade.order(:nome)
  end
  
  def manage_params
    if (!params[:cliente].nil?) 
       params[:cliente].delete_if{|k,v| v.blank?}
    end
  end
  
end
