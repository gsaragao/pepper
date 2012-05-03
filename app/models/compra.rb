# encoding: UTF-8
class Compra < ActiveRecord::Base
  has_many :despesas
  before_destroy :no_despesas
  attr_accessible :data, :descricao, :observacao
  validates_presence_of :descricao, :data
  
  self.per_page = 10

  def self.pesquisar(obj, page)
    descricao = obj ? obj[:descricao] : ""

    if (obj && obj[:data]) 
      where("compras.descricao like ? and compras.data = ?", "%#{descricao}%", obj[:data]).paginate(:page => page).order("descricao, data")
    else
      where("compras.descricao like ?", "%#{descricao}%").paginate(:page => page).order("descricao, data")
    end  
  end
  
  def total_despesas
    total = 0.0

    if !despesas.empty?
      despesas.each {|desp| 
        total+=desp.valor
      }
    end
    total
  end

  private

   def no_despesas
     return if despesas.empty?
      errors[:base] << "Esta compra tem despesa(s) associada(s): #{despesas.size} registro(s)!"
     false
   end
   
end
