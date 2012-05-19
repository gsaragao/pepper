# encoding: UTF-8
class TipoDespesa < ActiveRecord::Base
  has_many :despesas
  attr_accessible :descricao, :retorno, :observacao
  validates_presence_of :descricao, :retorno
  validates_uniqueness_of :descricao, :message => "Este registro já foi cadastrado!"
  before_destroy :no_children
  
  self.per_page = 10

  def self.pesquisar(obj, page)
    descricao = obj ? obj[:descricao] : ""
    where("tipo_despesas.descricao like ?", "%#{descricao}%").paginate(:page => page).order("descricao")
  end
  
  private

  def no_children
    return if despesas.empty?
     errors[:base] << "Este tipo despesa tem despesa(s) associada(s): #{despesas.size} registro(s)!"
    false
  end
  
end
