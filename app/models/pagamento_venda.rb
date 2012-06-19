# encoding: UTF-8
class PagamentoVenda < ActiveRecord::Base
  belongs_to :venda
  validates_presence_of :forma_pagamento, :parcela, :valor, :data
  attr_accessor :cliente_id, :lista, :lista_formas
  attr_accessible :cliente_id, :lista, :forma_pagamento
  self.per_page = 10
  after_initialize :default_values  

    def default_values
      self.lista_formas = {"Dinheiro" => 1, "Cartão" => 2, "Cheque" => 3, "Duplicata" => 4}
    end
  
  PENDENTE = 'PE'
  PAGO = 'PG'
  DINHEIRO = 1
  DUPLICATA = 4
  
  def self.pesquisar_por_venda(id)
    select("forma_pagamento, max(parcela) as parcela, avg(valor) as valor, min(data) as data").where("venda_id = ?", id).group("forma_pagamento")
  end
  
  def self.pesquisar(obj, page)
    
      query = select("pagamento_vendas.*")
      
      if obj 
        query = query.where("data_pagamento_cliente is null") if obj[:lista] == PagamentoVenda::PENDENTE
        query = query.where("data_pagamento_cliente is not null") if obj[:lista] == PagamentoVenda::PAGO
        query = query.where("vendas.cliente_id = ?", obj[:cliente_id]) if obj[:cliente_id]
        query = query.where("forma_pagamento = ?", obj[:forma_pagamento]) if obj[:forma_pagamento]
      end
      
      query = query.joins(:venda => :cliente).paginate(:page => page).order("data")
  end
  
  def descricao_forma
    lista_formas.key(forma_pagamento)
  end
  
  def self.proximos_seis_meses
      query = where("DATE_FORMAT(pagamento_vendas.data , '%m/%Y') >= DATE_FORMAT(sysdate() , '%m/%Y')")
      query = query.group("DATE_FORMAT(pagamento_vendas.data , '%m/%Y')")
      query.select("pagamento_vendas.data, sum(pagamento_vendas.valor) as valor")
  end
  
  def self.total_proximos_seis_meses
    retorno = 0
    pagamentos = proximos_seis_meses
    pagamentos.each {|pag|
      retorno+= pag.valor
    }
    retorno 
  end
  
  def self.relacao_forma_pagamento
    select("forma_pagamento, sum(valor) as valor").group("forma_pagamento")
  end
  
  def self.total_pagamento
    sum("valor")
  end

end