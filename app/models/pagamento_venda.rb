# encoding: UTF-8
class PagamentoVenda < ActiveRecord::Base
  belongs_to :venda
  validates_presence_of :forma_pagamento, :parcela, :valor, :data
  
  def self.pesquisar_por_venda(id)
    select("forma_pagamento, max(parcela) as parcela, avg(valor) as valor, min(data) as data").where("venda_id = ?", id).group("forma_pagamento")
  end
  
end