# encoding: UTF-8
class Compra < ActiveRecord::Base
  has_many :despesas
  before_destroy :no_despesas
  attr_accessible :data, :descricao, :observacao, :default
  validates_presence_of :descricao, :data
  
  self.per_page = 10
  
  DEFAULT = 1
  TAXA_RAVE = 5
  TAXA_CARTAO = 5
  
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
  
  def total_com_retorno
    total = 0.0

    if !despesas.empty?
      despesas.each {|desp| 
        if desp.tipo_despesa.retorno == 1
           total+=desp.valor
        end   
      }
    end
    total
  end
  
  def total_sem_retorno
    total_despesas - total_com_retorno
  end
  
  def calcula_percentual_despesa
    
      tot_desp = total_despesas
      tot_desp_ret = total_com_retorno
      retorno = 0
      
      if tot_desp_ret > 0
         retorno = (((tot_desp - tot_desp_ret) / tot_desp_ret) * 100).round(1)
      end
      
      retorno += TAXA_RAVE + TAXA_CARTAO 
  end
  
  private

   def no_despesas
     return if despesas.empty?
      errors[:base] << "Esta compra tem despesa(s) associada(s): #{despesas.size} registro(s)!"
     false
   end
   
end
