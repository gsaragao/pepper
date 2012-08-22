# encoding: UTF-8
class Compra < ActiveRecord::Base
  include ActionView::Helpers::NumberHelper
  has_many :despesas
  has_many :produtos
  before_destroy :sem_despesas
  before_destroy :sem_produtos
  attr_accessible :data, :descricao, :observacao, :default
  validates_presence_of :descricao, :data
  
  self.per_page = 10
  
  DEFAULT = 1
  TAXA_RAVE = 5
  TAXA_CARTAO = 5
  
  def self.pesquisar(obj, page)
    descricao = obj ? obj[:descricao] : ""

    if (obj && obj[:data]) 
      includes(:despesas => :tipo_despesa).where("compras.descricao like ? and compras.data = ?", "%#{descricao}%", obj[:data]).paginate(:page => page).order("descricao, data")
    else
      includes(:despesas => :tipo_despesa).where("compras.descricao like ?", "%#{descricao}%").paginate(:page => page).order("descricao, data")
    end  
  end
  
  def total_despesas
    total = 0.0

    if !despesas.empty?
      despesas.each {|desp| 
        total+=desp.valor if desp.valor
      }
    end
    total
  end
  
  def total_com_retorno
    total = 0.0

    if !despesas.empty?
      despesas.each {|desp| 
        if desp.tipo_despesa.retorno == 1
           total+=desp.valor if desp.valor
        end   
      }
    end
    total
  end
  
  def total_sem_retorno
    total_despesas - total_com_retorno
  end
  
  def total_lucro
    total_retorno_produtos - total_despesas
  end
  
  def total_retorno_produtos
    total = 0.0

    if !produtos.empty?
      produtos.each {|prod| 
           total+=prod.valor_venda if prod.valor_venda
      }
    end
    total
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
  
  def lucro_real
    total_vendido - total_despesas
  end
  
  def lucratividade_real
      retorno = 0.0
      if (despesas.size > 0 && produtos.size > 0)
        retorno = (((total_vendido - total_despesas) / total_vendido.to_f) * 100)
      end  
      retorno
  end
  
  def rentabilidade_real
    retorno = 0.0
    if (despesas.size > 0 && produtos.size > 0)
      retorno = (((total_vendido - total_despesas) / total_despesas.to_f) * 100)
    end  
    retorno
  end
  
  def prazo_retorno_real
    retorno = 0.0
    if (despesas.size > 0 && produtos.size > 0)
      retorno = (total_despesas / (total_vendido - total_despesas).to_f)
    end
    retorno
  end
  
  def calcula_percentual_despesa
    
      tot_desp = total_despesas
      tot_desp_ret = total_com_retorno
      retorno = 0
      
      if tot_desp_ret > 0
         retorno = (((tot_desp - tot_desp_ret) / tot_desp_ret.to_f) * 100)
      end
      
      retorno += TAXA_RAVE + TAXA_CARTAO
      retorno.to_f 
  end
  
  def lucratividade
      retorno = 0.0
      if (despesas.size > 0 && produtos.size > 0)
        retorno = (((total_retorno_produtos - total_despesas) / total_retorno_produtos.to_f) * 100)
      end  
      retorno
  end
  
  def rentabilidade
    retorno = 0.0
    if (despesas.size > 0 && produtos.size > 0)
      retorno = (((total_retorno_produtos - total_despesas) / total_despesas.to_f) * 100)
    end  
    retorno
  end
  
  def prazo_retorno
    retorno = 0.0
    if (despesas.size > 0 && produtos.size > 0)
      retorno = (total_despesas / (total_retorno_produtos - total_despesas).to_f)
    end
    retorno
  end
  
  private

   def sem_despesas
     return if despesas.empty?
      errors[:base] << "Esta compra tem despesa(s) associada(s): #{despesas.size} registro(s)!"
     false
   end
   
   def sem_produtos
      return if produtos.empty?
       errors[:base] << "Esta compra tem produtos(s) associado(s): #{produtos.size} registro(s)!"
      false
    end
   
end
