# encoding: UTF-8
class Tamanho < ActiveRecord::Base
  attr_accessible :descricao, :observacao, :default
  validates_presence_of :descricao
  validates_uniqueness_of :descricao, :message => "Este registro já foi cadastrado!"
  
  self.per_page = 10
  DEFAULT = 1

  def self.pesquisar(obj, page)
    descricao = obj ? obj[:descricao] : ""
    where("tamanhos.descricao like ?", "%#{descricao}%").paginate(:page => page).order("descricao")
  end
  
end
