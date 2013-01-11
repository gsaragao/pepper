# encoding: UTF-8
class PagamentoDespesa < ActiveRecord::Base
  belongs_to :despesa
  usar_como_dinheiro :valor
  validates_presence_of :forma_pagamento, :parcela, :valor, :data
  
  def self.proximos_pagamentos
      query = select("pagamento_despesas.data, sum(pagamento_despesas.valor) as valor")
      query = query.where("DATE_FORMAT(pagamento_despesas.data , '%Y-%m') >= DATE_FORMAT(sysdate() , '%Y-%m')")
      query = query.group("DATE_FORMAT(pagamento_despesas.data , '%Y-%m')")
      query
  end
  
  def self.total_proximos_pagamentos
    retorno = 0
    pagamentos = proximos_pagamentos
    pagamentos.each {|pag|
      retorno+= pag.valor
    }
    retorno 
  end

  def self.ultimos_seis_pagamentos
      query = select("pagamento_despesas.data, sum(pagamento_despesas.valor) as valor")
      query = query.where("DATE_FORMAT(pagamento_despesas.data , '%Y-%m') < DATE_FORMAT(sysdate() , '%Y-%m')")
      query = query.group("DATE_FORMAT(pagamento_despesas.data , '%Y-%m')")
      query = query.order("DATE_FORMAT(pagamento_despesas.data , '%Y') desc, DATE_FORMAT(pagamento_despesas.data , '%m') desc")
      query = query.limit(4)
      query
  end

  def self.total_ultimos_pagamentos
    retorno = 0
    pagamentos = ultimos_seis_pagamentos
    pagamentos.each {|pag|
      retorno+= pag.valor
    }
    retorno 
  end

end
