# encoding: UTF-8
class Venda < ActiveRecord::Base
  belongs_to :cliente
  belongs_to :vendedor
  has_many :produtos, :dependent => :nullify
  #has_many :pagamentos_vendas
  attr_accessible :data, :observacao, :cliente_id, :vendedor_id, :lista_produtos
  validates_presence_of :data, :cliente_id, :vendedor_id
  validates_presence_of :lista_produtos, :message => "está vazia!"

  attr_accessor :lista_produtos
  
  self.per_page = 10
  
  def self.pesquisar(obj, page)
    where(obj).paginate(:page => page).order("data")
  end
  
  def total_vendido
    total = 0.0

    if !produtos.empty?
      produtos.each {|prod| 
        total+=prod.valor_vendido if prod.valor_vendido
      }
    end
    total
  end
  
  def total_sugerido
    total = 0.0

    if !produtos.empty?
      produtos.each {|prod| 
        total+=prod.valor_venda if prod.valor_venda
      }
    end
    total
  end
  
end
