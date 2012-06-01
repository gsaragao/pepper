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
  :parcela_cartao, :valor_cartao, :data_cartao, :parcela_cheque, :valor_cheque, :data_cheque
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
    where(obj).paginate(:page => page).order("data")
  end
  
  def total_pagamento
    total = 0.0

    if !pagamento_vendas.empty?
      pagamento_vendas.each {|pag| 
        total+=pag.valor
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
    vendido = total_vendido
    if pagamento !=  vendido
      errors.add(:total_pagamento,"#{number_to_currency(pagamento)} deve ser igual ao total comprado #{number_to_currency(vendido)} .")
    end  
  end
  
  def total_pagamento_tela
    total = 0;
    total += valor_dinheiro.to_f if valor_dinheiro
    total += valor_duplicata.to_f if valor_duplicata
    total += valor_cartao.to_f if valor_cartao
    total += valor_cheque.to_f if valor_cheque
    total
  end
  
end
