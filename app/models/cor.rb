# encoding: UTF-8
class Cor < ActiveRecord::Base
  has_many :produtos
  before_destroy :sem_produtos
  attr_accessible :descricao, :observacao
  validates_presence_of :descricao
  validates_uniqueness_of :descricao, :message => "Este registro já foi cadastrado!"
  
  self.per_page = 10

  def self.pesquisar(obj, page)
    descricao = obj ? obj[:descricao] : ""
    where("cores.descricao like ?", "%#{descricao}%").paginate(:page => page).order("descricao")
  end
  
  private
  
  def sem_produtos
    return if produtos.empty?
      errors[:base] << "Esta cor tem produtos(s) associado(s): #{produtos.size} registro(s)!"
     false
  end
  
end
