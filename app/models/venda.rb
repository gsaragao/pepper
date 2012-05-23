# encoding: UTF-8
class Venda < ActiveRecord::Base
  belongs_to :cliente
  belongs_to :vendedor
  has_many :produtos
  #has_many :pagamentos_vendas
  attr_accessible :data, :observacao, :cliente_id, :vendedor_id, :lista_prod
  validates_presence_of :data, :cliente_id, :vendedor_id

  attr_accessor :lista_prod
  
  self.per_page = 10
  
  def self.pesquisar(obj, page)
    where(obj).paginate(:page => page).order("data")
  end
  
end
