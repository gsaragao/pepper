# encoding : utf-8
class ProdutosController < ApplicationController

  respond_to :html
  before_filter :setar_classe_menu
  before_filter :manage_params, :only => [:index]
  before_filter :load_produto , :only => [:show, :edit, :update, :destroy]

  def index
    @compras = Compra.order(:data)
    @produto = Produto.new(params[:produto])
    @produtos = Produto.pesquisar(params[:produto],params[:page])
    respond_with @produtos
  end
  
  def show
    respond_with @produto
  end

  def new
    load_combos
    @compra_default = Compra.find_by_default(Produto::COPY)
    @tamanho_default = Tamanho.find_by_default(Produto::COPY)
    @produto = Produto.new
    @produto.compra_id = @compra_default.id if @compra_default
    @produto.tamanho_id = @tamanho_default.id if @tamanho_default
    @produto.quantidade = 1
    
    respond_with @produto
  end
  
  def edit
    load_combos
 
    if (!params[:acao].nil? && params[:acao] == Produto::COPY)
      @produto = @produto.dup
      @produto.codigo_interno = nil
      @produto.descricao = nil
      @produto.acao = Produto::COPY
    end  
  end

  def create
    @produto = Produto.new(params[:produto])
    save = false
    codigo = @produto.codigo_interno.to_i
    Produto.transaction do |t|
      
      if (@produto.quantidade && @produto.quantidade.to_i > 0)
        
        @produto.quantidade.to_i.times { |i|
          if @produto.save
            save = true
          else
            save = false
            break
          end    
          @produto = @produto.dup
          @produto.codigo_interno = codigo + i + 1
        }
      end
            
      if save
        flash[:notice] = t('msg.create_sucess')
        redirect_to produtos_path
      else
        load_combos
        render :action => :new 
        raise ActiveRecord::Rollback
      end
    end
  end

  def update
    if @produto.update_attributes(params[:produto])
      flash[:notice] = t('msg.update_sucess')
      redirect_to produtos_path
    else
      load_combos
      render :action => :edit
    end
  end

  def destroy
    
    if @produto.destroy
      flash[:notice] = t('msg.destroy_sucess')
    else
      flash[:alert] = @produto.errors.full_messages[0]
    end

    redirect_to produtos_path
  end
  
  private
  
  def setar_classe_menu
    @class_produto = 'active'  
  end
  
  def load_produto
    begin
      @produto = Produto.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      flash[:alert] = t('msg.data_not_found')
      redirect_to produtos_path
    end
  end
  
  def load_combos 
    @categorias = Categoria.order(:descricao)
    @fornecedores = Fornecedor.order(:nome) 
    @compras = Compra.order(:data)
    @marcas = Marca.order(:descricao)
    @cores = Cor.order(:descricao)
    @tamanhos = Tamanho.order(:descricao)
  end
  
  def manage_params
    if (!params[:produto].nil?) 
       params[:produto].delete_if{|k,v| v.blank?}
    end
  end
  
end
