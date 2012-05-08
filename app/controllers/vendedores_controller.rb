# encoding : utf-8
class VendedoresController < ApplicationController

  respond_to :html
  before_filter :setar_classe_menu
  before_filter :manage_params, :only => [:index]
  before_filter :load_vendedor , :only => [:show, :edit, :update, :destroy]

  def index
    @cidades = Cidade.order(:nome)
    @vendedor = Vendedor.new(params[:vendedor])
    @vendedores = Vendedor.pesquisar(params[:vendedor],params[:page])
    respond_with @vendedores
  end

  def show
    respond_with @vendedor
  end

  def new
    load_combos
    @vendedor = Vendedor.new
    respond_with @vendedor
  end

  def edit
    load_combos
  end

  def create
    @vendedor = Vendedor.new(params[:vendedor])
    Vendedor.transaction do
      valida_check(@vendedor.default)
      if @vendedor.save
        flash[:notice] = t('msg.create_sucess')
        redirect_to vendedores_path
      else
        load_combos
        render :action => :new 
      end
    end 
  end

  def update
    Vendedor.transaction do
      valida_check(params[:vendedor][:default])
      if @vendedor.update_attributes(params[:vendedor])
        flash[:notice] = t('msg.update_sucess')
        redirect_to vendedores_path
      else
        load_combos
        render :action => :edit
      end
    end  
  end

  def destroy
    
    if @vendedor.destroy
      flash[:notice] = t('msg.destroy_sucess')
    else
      flash[:alert] = @vendedor.errors.full_messages[0]
    end

    redirect_to vendedores_path
  end
  
  private
  
  def setar_classe_menu
    @class_vendedor = 'active'  
  end
  
  def load_vendedor
    begin
      @vendedor = Vendedor.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      flash[:alert] = t('msg.data_not_found')
      redirect_to vendedores_path
    end
  end
  
  def load_combos 
    @cidades = Cidade.order(:nome)
  end
  
  def manage_params
    if (!params[:vendedor].nil?) 
       params[:vendedor].delete_if{|k,v| v.blank?}
    end
  end
  
  def valida_check(value)
     if (value == 1 || value == '1')
       Vendedor.update_all(:default => nil)
     end   
  end

end
