# encoding: UTF-8
class PagamentoDespesa < ActiveRecord::Base
  belongs_to :despesa
  validates_presence_of :forma_pagamento, :parcela, :valor, :data
  
  def self.proximos_seis_meses
      select("pagamento_despesas.data, sum(pagamento_despesas.valor) as valor").where("DATE_FORMAT(pagamento_despesas.data , '%m/%Y') >= DATE_FORMAT(sysdate() , '%m/%Y')").group("DATE_FORMAT(pagamento_despesas.data , '%m/%Y')")
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
