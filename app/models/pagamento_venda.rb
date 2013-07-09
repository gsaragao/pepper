# encoding: UTF-8
class PagamentoVenda < ActiveRecord::Base
  belongs_to :venda
  usar_como_dinheiro :valor, :valor_pago, :recalculo
  validates_presence_of :forma_pagamento, :parcela, :valor, :data
  validates_numericality_of :valor_pago, :if => Proc.new { |pagamento_venda| !pagamento_venda.valor_pago.blank? }
  validates_numericality_of :valor_pago, :greater_than_or_equal_to => 1, :if => Proc.new { |pagamento_venda| !pagamento_venda.valor_pago.blank? }
  validates_presence_of :valor_pago, :if => Proc.new { |pagamento_venda| !pagamento_venda.data_pagamento_cliente.blank? }
  attr_accessor :cliente_id, :lista, :lista_formas
  attr_accessible :cliente_id, :lista, :forma_pagamento, :valor_pago, :data_pagamento_cliente, :recalculo
  self.per_page = 10
  after_initialize :default_values  

    def default_values
      self.lista_formas = {"Dinheiro" => 1, "Cartão" => 2, "Cheque" => 3, "Duplicata" => 4}
    end
  
  AVENCER = 'PE'
  ATRASADO = 'AT'
  PAGO = 'PG'
  DINHEIRO = 1
  DUPLICATA = 4
  
  def self.pesquisar_por_venda(id)
    query = select("forma_pagamento, max(parcela) as parcela, avg(valor) as valor, min(data) as data")
    query = query.where("venda_id = ?", id)
    query = query.group("forma_pagamento")
    query
  end
 
=begin 
  def self.pesquisar(obj, page)
    
      query = includes(:venda => :cliente)
     
      if obj 
        query = query.where("data_pagamento_cliente is null and pagamento_vendas.data < ?", Date.today) if obj.lista == PagamentoVenda::ATRASADO
        query = query.where("data_pagamento_cliente is null") if obj.lista == PagamentoVenda::AVENCER
        query = query.where("data_pagamento_cliente is not null") if obj.lista == PagamentoVenda::PAGO
        query = query.where("vendas.cliente_id = ?", obj.cliente_id) if obj.cliente_id
        
        if obj.forma_pagamento != 0
          query = query.where("forma_pagamento = ?", obj.forma_pagamento) 
        else
          query = query.where("forma_pagamento in (1,4)", obj.forma_pagamento) 
        end    
      else
        query = query.where("forma_pagamento in (1,4) and data_pagamento_cliente is null") 
      end  
     
      query = query.paginate(:page => page).order("pagamento_vendas.data")
  end
=end  
  
  def pesquisar(page)
    query = PagamentoVenda.paginate(:conditions => conditions, :page => page).order("pagamento_vendas.data")
    query = query.includes(:venda => :cliente)
    query
  end


  def descricao_forma
    lista_formas.key(forma_pagamento)
  end
  
  def self.proximos_recebimentos
      query = where("DATE_FORMAT(pagamento_vendas.data , '%Y-%m') >= DATE_FORMAT(sysdate() , '%Y-%m')")
      query = query.group("DATE_FORMAT(pagamento_vendas.data , '%Y-%m')")
      query.select("pagamento_vendas.data, sum(pagamento_vendas.valor) as valor")
  end
  
  def self.total_proximos_recebimentos
    retorno = 0
    pagamentos = proximos_recebimentos
    pagamentos.each {|pag|
      retorno+= pag.valor
    }
    retorno 
  end
  
  def self.ultimos_seis_recebimentos
      query = where("DATE_FORMAT(pagamento_vendas.data , '%Y-%m') < DATE_FORMAT(sysdate() , '%Y-%m')")
      query = query.group("DATE_FORMAT(pagamento_vendas.data , '%Y-%m')")
      query = query.order("DATE_FORMAT(pagamento_vendas.data , '%Y') desc, DATE_FORMAT(pagamento_vendas.data , '%m') desc")
      query = query.limit(4)
      query.select("pagamento_vendas.data, sum(pagamento_vendas.valor) as valor")
  end
  
  def self.total_ultimos_recebimentos
    retorno = 0
    pagamentos = ultimos_seis_recebimentos
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

  def self.total_por_forma_venda(venda_id)
    sum("valor", :conditions => ["forma_pagamento = ? and venda_id = ?", PagamentoVenda::DUPLICATA, venda_id])
  end

  def self.total_pago_forma_venda(venda_id)
    sum("valor_pago", :conditions => ["forma_pagamento = ? and venda_id = ? and data_pagamento_cliente is not null", PagamentoVenda::DUPLICATA, venda_id])
  end

  def self.qtde_parcelas_por_forma_venda(venda_id)
    maximum("parcela", :conditions => ["forma_pagamento = ? and venda_id = ?", PagamentoVenda::DUPLICATA, venda_id])
  end

  def self.pesquisar_por_venda_duplicata(venda_id)
    where("forma_pagamento = ? and venda_id = ? and data_pagamento_cliente is null", PagamentoVenda::DUPLICATA, venda_id)
  end

  private

  def data_pagamento_cliente_conditions
    ["pagamento_vendas.data_pagamento_cliente = ?", data_pagamento_cliente] unless data_pagamento_cliente.blank?
  end
    
  def forma_pagamento_conditions
    saida = nil
    if forma_pagamento.blank?
      saida = ["pagamento_vendas.forma_pagamento in (1,4)"] 
    else
      saida = ["pagamento_vendas.forma_pagamento = ?", forma_pagamento]
    end 
    saida 
  end  
    
  def cliente_id_conditions
    ["vendas.cliente_id = ?", cliente_id] unless cliente_id.blank?
  end

  def lista_conditions
    saida = nil
      if lista == PagamentoVenda::ATRASADO 
        saida = ["data_pagamento_cliente is null and pagamento_vendas.data < ?", Date.today]
      elsif lista == PagamentoVenda::AVENCER  
        saida = ["data_pagamento_cliente is null"]
      elsif lista == PagamentoVenda::PAGO  
        saida = ["data_pagamento_cliente is not null"]
      end  
    saida  
  end

  def conditions
    [conditions_clauses.join(' AND '), *conditions_options]
  end

  def conditions_clauses
    conditions_parts.map { |condition| condition.first }
  end

  def conditions_options
    conditions_parts.map { |condition| condition[1..-1] }.flatten
  end

  def conditions_parts
    private_methods(false).grep(/_conditions$/).map { |m| send(m) }.compact
  end

end