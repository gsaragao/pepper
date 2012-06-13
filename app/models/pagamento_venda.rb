# encoding: UTF-8
class PagamentoVenda < ActiveRecord::Base
  belongs_to :venda
  validates_presence_of :forma_pagamento, :parcela, :valor, :data
  attr_accessor :cliente_id, :lista
  attr_accessible :cliente_id, :lista
  self.per_page = 10
  
  PENDENTE = 'PE'
  PAGO = 'PG'
  
  def self.pesquisar_por_venda(id)
    select("forma_pagamento, max(parcela) as parcela, avg(valor) as valor, min(data) as data").where("venda_id = ?", id).group("forma_pagamento")
  end
  
  def self.pesquisar(obj, page)
      sql = "" 
      if obj && obj[:lista]
        sql = "data_pagamento_cliente is null and" if obj[:lista] == PagamentoVenda::PENDENTE
        sql = "data_pagamento_cliente is not null and" if obj[:lista] == PagamentoVenda::PAGO
      end
      
      if obj && obj[:cliente_id]
        where(sql + " forma_pagamento in (1,4) and vendas.cliente_id = ?", obj[:cliente_id]).joins(:venda => :cliente).paginate(:page => page).order("nome, parcela")
      else    
        where(sql + " forma_pagamento in (1,4)").joins(:venda => :cliente).paginate(:page => page).order("nome, parcela")
      end
  end
  
  def descricao_forma
    venda.lista_formas.key(forma_pagamento)
  end
  
  def self.proximos_seis_meses
      select("pagamento_vendas.data, sum(pagamento_vendas.valor) as valor").where("DATE_FORMAT(pagamento_vendas.data , '%m/%Y') >= DATE_FORMAT(sysdate() , '%m/%Y')").group("DATE_FORMAT(pagamento_vendas.data , '%m/%Y')")
  end
  
  def self.total_proximos_seis_meses
    retorno = 0
    pagamentos = proximos_seis_meses
    pagamentos.each {|pag|
      retorno+= pag.valor
    }
    retorno 
  end

end