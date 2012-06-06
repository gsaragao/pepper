# encoding: UTF-8
class PagamentoVenda < ActiveRecord::Base
  belongs_to :venda
  validates_presence_of :forma_pagamento, :parcela, :valor, :data, :data_pagamento_cliente
  attr_accessor :cliente_id
  attr_accessible :cliente_id
  self.per_page = 10
  
  def self.pesquisar_por_venda(id)
    select("forma_pagamento, max(parcela) as parcela, avg(valor) as valor, min(data) as data").where("venda_id = ?", id).group("forma_pagamento")
  end
  
  def self.pesquisar(obj, page)
    
    if obj && obj[:cliente_id]
      where("forma_pagamento = ? and vendas.cliente_id = ?", Venda::DUPLICATA, obj[:cliente_id]).joins(:venda => :cliente).paginate(:page => page).order("nome, parcela")
    else    
      where("forma_pagamento = ?", Venda::DUPLICATA).joins(:venda => :cliente).paginate(:page => page).order("nome, parcela")
    end
  end
  
  def descricao_forma
    venda.lista_formas.key(forma_pagamento)
  end
  
end