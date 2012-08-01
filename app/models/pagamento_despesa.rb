# encoding: UTF-8
class PagamentoDespesa < ActiveRecord::Base
  belongs_to :despesa
  validates_presence_of :forma_pagamento, :parcela, :valor, :data
  
  def self.proximos_pagamentos
      query = select("pagamento_despesas.data, sum(pagamento_despesas.valor) as valor")
      query = query.where("DATE_FORMAT(pagamento_despesas.data , '%m/%Y') >= DATE_FORMAT(sysdate() , '%m/%Y')")
      query = query.group("DATE_FORMAT(pagamento_despesas.data , '%m/%Y')")
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
      query = query.where("DATE_FORMAT(pagamento_despesas.data , '%m/%Y') < DATE_FORMAT(sysdate() , '%m/%Y')")
      query = query.group("DATE_FORMAT(pagamento_despesas.data , '%m/%Y')")
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
