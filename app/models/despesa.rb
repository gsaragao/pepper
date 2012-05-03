# encoding: UTF-8
class Despesa < ActiveRecord::Base
  belongs_to :compra
  belongs_to :tipo_despesa
  belongs_to :fornecedor
  attr_accessible :data, :valor, :observacao, :tipo_despesa_id, :compra_id, :fornecedor_id, :descricao
  validates_presence_of :compra, :tipo_despesa, :fornecedor_id, :valor, :descricao
   
  self.per_page = 10

  def self.pesquisar(obj, page)
    where(obj).paginate(:page => page).order("id desc")
  end
  
end
