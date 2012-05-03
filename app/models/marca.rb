# encoding: UTF-8
class Marca < ActiveRecord::Base
  attr_accessible :descricao, :observacao
  validates_presence_of :descricao
  validates_uniqueness_of :descricao, :message => "Este registro já foi cadastrado!"
  
  self.per_page = 10

  def self.pesquisar(obj, page)
    descricao = obj ? obj[:descricao] : ""
    where("marcas.descricao like ?", "%#{descricao}%").paginate(:page => page).order("descricao")
  end
  
end
