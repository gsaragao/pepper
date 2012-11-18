# encoding: UTF-8
class Cliente < ActiveRecord::Base
  belongs_to :cidade
  has_many :vendas
  before_destroy :sem_vendas
  attr_accessible :cidade_id, :email, :endereco, :nome, :telefone, :observacao
  validates_presence_of :nome
  validates_uniqueness_of :nome, :scope => :cidade_id, :message => "Este registro já foi cadastrado para esta cidade!"
  validates_format_of :email, 
                      :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i, 
                      :message    => 'Inválido!',
                      :allow_blank => true                    
  
  self.per_page = 10

  def self.pesquisar(obj, page)
    nome = obj ? obj[:nome] : ""
    if (obj && obj[:cidade_id]) 
      includes(:cidade).where("clientes.nome like ? and clientes.cidade_id = ?", "%#{nome}%", obj[:cidade_id]).paginate(:page => page).order("nome")
    else
      includes(:cidade).where("clientes.nome like ?", "%#{nome}%").paginate(:page => page).order("nome")
    end    
  end

  def self.relacao_pagamento
    sql  = ' select c.nome, min(p.data) data, p.valor '
    sql += ' from vendas v, clientes c, pagamento_vendas p where v.cliente_id = c.id '
    sql += ' and p.venda_id = v.id and p.data_pagamento_cliente is null '
    sql += ' and p.forma_pagamento in (1,4) '
    sql += ' group by c.id order by 2 limit 15 '
    
    find_by_sql(sql)
  end
  
  def self.com_pagamento
    where(" pagamento_vendas.forma_pagamento in (1,4) ").joins(:vendas => :pagamento_vendas).group("clientes.id").order("nome")
  end
  
  private
  
  def sem_vendas
    return if vendas.empty?
      errors[:base] << "Este cliente tem venda(s) associada(s): #{vendas.size} registro(s)!"
     false
  end
  
end
