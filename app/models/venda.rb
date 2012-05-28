# encoding: UTF-8
class Venda < ActiveRecord::Base
  belongs_to :cliente
  belongs_to :vendedor
  has_many :produtos
  #has_many :pagamentos_vendas
  attr_accessible :data, :observacao, :cliente_id, :vendedor_id, :lista_prod, :produtos_attributes
  validates_presence_of :data, :cliente_id, :vendedor_id
  accepts_nested_attributes_for :produtos

  attr_accessor :lista_prod
  
  self.per_page = 10
  
  def self.pesquisar(obj, page)
    where(obj).paginate(:page => page).order("data")
  end
  
  def total_vendido
    total = 0.0

    if !produtos.empty?
      produtos.each {|prod| 
        total+=prod.valor_venda
      }
    end
    total
  end
  
end
