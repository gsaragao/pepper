# encoding : utf-8
class HomeController < ApplicationController

  respond_to :html
  before_filter :setar_classe_menu

  def index
    #@clientes = Cliente.all
    #@fornecedores = Fornecedor.all
    #@compras = Compra.all
    #@despesas = Despesa.all
    #@cidades = Cidade.all
    #@categorias = Categoria.all
    #@tipo_despesas = TipoDespesa.all
    #@cores = Cor.all
    #@marcas = Marca.all
    #@tamanhos = Tamanho.all
    #@vendedores = Vendedor.all
  end
 
  private
  
  def setar_classe_menu
    @class_home = 'active'  
  end

end
