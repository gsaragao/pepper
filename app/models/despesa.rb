# encoding: UTF-8
class Despesa < ActiveRecord::Base
  belongs_to :compra
  belongs_to :tipo_despesa
  belongs_to :fornecedor
  has_many :pagamento_despesas, :dependent => :delete_all
  attr_accessible :data, :valor, :observacao, :tipo_despesa_id, :compra_id, :fornecedor_id, :descricao,
                  :forma_pagamento, :parcela, :valor_pagamento, :data_pagamento
  validates_presence_of :compra, :tipo_despesa, :fornecedor_id, :valor, :descricao, :data_pagamento
  validate :valida_forma_pagamento
  self.per_page = 10
  COPY = '1'
  attr_accessor :lista_formas, :forma_pagamento, :parcela, :valor_pagamento, :data_pagamento, :acao
  after_initialize :default_values  
  
  def default_values
    self.lista_formas = {"Dinheiro" => 1, "Cartão" => 2, "Cheque" => 3}
  end
  
  DINHEIRO = 1
  CARTAO = 2
  CHEQUE = 3

  def self.pesquisar(obj, page)
    where(obj).paginate(:page => page).order("data")
  end
  
  def valida_forma_pagamento
    errors.add :forma_pagamento, "Dinheiro não tem parcelas!" if (forma_pagamento.to_i == DINHEIRO) && (parcela.to_i > 1) 
  end
  
end
