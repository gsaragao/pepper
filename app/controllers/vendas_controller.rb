# encoding : utf-8
class VendasController < ApplicationController

  respond_to :html
  before_filter :setar_classe_menu
  before_filter :manage_params, :only => [:index]
  before_filter :load_venda , :only => [:show, :edit, :update, :destroy]

  def index
    @clientes = Cliente.order(:nome)
    @vendedores = Vendedor.order(:nome)
    @venda = Venda.new(params[:venda])
    @vendas = Venda.pesquisar(params[:venda],params[:page])
    respond_with @vendas
  end

  def show
    respond_with @venda
  end

  def new
    load_combos
    @vendedor_default = Vendedor.find_by_default(Vendedor::DEFAULT)
    @venda = Venda.new
    @venda.vendedor_id = @vendedor_default.id
    respond_with @venda
  end

  def edit
    load_combos
  end

  def create
  
    @venda = Venda.new(params[:venda])
    @venda.produtos = []
    if @venda.lista_produtos
      @venda.lista_produtos.each {|k,v|
        produto = Produto.find(v[:id]) 
        produto.valor_vendido = v[:valor_vendido]
        @venda.produtos << produto
      }
    end
    Venda.transaction do
      if @venda.save
  
        @venda.produtos.each {|prod| 
          prod.venda_id = @venda.id
          prod.save
        }
        
        flash[:notice] = t('msg.create_sucess')
        redirect_to vendas_path
      else
        load_combos
        render :action => :new 
        raise ActiveRecord::Rollback
      end
    end 
  end

  def update
    
     Venda.transaction do  
        if @venda.update_attributes(params[:venda])
          
          Produto.where(:venda_id => @venda.id).update_all(:venda_id => nil)
          
          @venda.lista_produtos.each {|k,v| 
            produto = Produto.find(v[:id]) 
            produto.valor_vendido = v[:valor_vendido]
            produto.venda_id = @venda.id
            produto.save
          }
          flash[:notice] = t('msg.update_sucess')
          redirect_to vendas_path
        else
          
          load_combos
           @venda.produtos = []
            if @venda.lista_produtos
              @venda.lista_produtos.each {|k,v| 
                produto = Produto.find(v[:id]) 
                produto.valor_vendido = v[:valor_vendido]
                @venda.produtos << produto 
              }
            end
          render :action => :edit
          raise ActiveRecord::Rollback
        end
     end  
  end

  def destroy
    
    if @venda.destroy
      flash[:notice] = t('msg.destroy_sucess')
    else
      flash[:alert] = @venda.errors.full_messages[0]
    end

    redirect_to vendas_path
  end
  
  private
  
  def setar_classe_menu
    @class_venda = 'active'  
  end
  
  def load_venda
    begin
      @venda = Venda.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      flash[:alert] = t('msg.data_not_found')
      redirect_to vendas_path
    end
  end
  
  def load_combos 
    @clientes = Cliente.order(:nome)
    @vendedores = Vendedor.order(:nome)
  end
  
  def manage_params
    if (!params[:venda].nil?) 
       params[:venda][:data] = trata_data(params[:venda][:data]) if params[:venda][:data]
       params[:venda].delete_if{|k,v| v.blank?}
    end
  end
  
end
