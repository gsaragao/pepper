# encoding: UTF-8
class Venda < ActiveRecord::Base
  include ActionView::Helpers::NumberHelper
  belongs_to :cliente
  belongs_to :vendedor
  has_many :produtos, :dependent => :nullify
  has_many :pagamento_vendas, :dependent => :delete_all
  attr_accessible :data, :observacao, :cliente_id, :vendedor_id, :lista_produtos, :valor_dinheiro, :parcela_duplicata, 
  :valor_duplicata, :data_duplicata, :parcela_cartao, :valor_cartao, :data_cartao, :parcela_cheque, :valor_cheque, :data_cheque
  validates_presence_of :data, :cliente_id, :vendedor_id
  validates_presence_of :lista_produtos, :message => "está vazia!"
  validates_presence_of :data_duplicata, :message => "deve ser selecionada.", :if => Proc.new { |venda| !venda.valor_duplicata.blank? }
  validates_presence_of :data_cartao, :message => "deve ser selecionada.", :if => Proc.new { |venda| !venda.valor_cartao.blank? }
  validates_presence_of :data_cheque, :message => "deve ser selecionada.", :if => Proc.new { |venda| !venda.valor_cheque.blank? }
  validate :valida_valor_pagamento
  attr_accessor :lista_produtos, :lista_formas, :valor_dinheiro, :parcela_duplicata, :valor_duplicata, :data_duplicata,
  :parcela_cartao, :valor_cartao, :data_cartao, :parcela_cheque, :valor_cheque, :data_cheque, :nome_cliente
  after_initialize :default_values  

   def default_values
     self.lista_formas = {"Dinheiro" => 1, "Cartão" => 2, "Cheque" => 3, "Duplicata" => 4}
   end

   DINHEIRO = 1
   CARTAO = 2
   CHEQUE = 3
   DUPLICATA = 4
  
  self.per_page = 10
  
  def self.pesquisar(obj, page)
    includes(:cliente, :vendedor, :produtos).where(obj).paginate(:page => page).order("data desc, id desc")
  end
  
  def total_pagamento
    total = 0.0

    if !pagamento_vendas.empty?
      pagamento_vendas.each {|pag| 
        total+=pag.valor if pag.valor
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
  
  def total_sugerido
    total = 0.0

    if !produtos.empty?
      produtos.each {|prod| 
        total+=prod.valor_venda if prod.valor_venda
      }
    end
    total
  end
  
  def valida_valor_pagamento
    pagamento = total_pagamento_tela
    vendido = total_vendido_tela
    if pagamento !=  vendido
      errors.add(:total_pagamento,"#{number_to_currency(pagamento)} deve ser igual ao total comprado #{number_to_currency(vendido)} .")
    end  
  end
  
  def total_vendido_tela
    total = 0.0
    if lista_produtos && !lista_produtos.empty?
      lista_produtos.each {|k,v| 
        total+=trata_valor(v[:valor_vendido]).to_f if v[:valor_vendido]
      }
    end
    total.round(2)
  end
  
  def total_pagamento_tela
    total = 0;
    total += trata_valor(valor_dinheiro.to_s).to_f if valor_dinheiro
    total += trata_valor(valor_duplicata.to_s).to_f if valor_duplicata
    total += trata_valor(valor_cartao.to_s).to_f if valor_cartao
    total += trata_valor(valor_cheque.to_s).to_f if valor_cheque
    total.round(2)
  end

  def trata_valor(valor) 
     valor = valor.sub('.',''); 
     valor = valor.sub(',','.');    
  end     

  
end
