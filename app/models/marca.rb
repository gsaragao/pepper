# encoding: UTF-8
class Marca < ActiveRecord::Base
  has_many :produtos
  before_destroy :sem_produtos
  attr_accessible :descricao, :observacao
  validates_presence_of :descricao
  validates_uniqueness_of :descricao, :message => "Este registro já foi cadastrado!"
  
  self.per_page = 10

  def self.pesquisar(obj, page)
    descricao = obj ? obj[:descricao] : ""
    where("marcas.descricao like ?", "%#{descricao}%").paginate(:page => page).order("descricao")
  end
  
  def self.relacao_vendidos
    
    sql  = ' select m.id, m.descricao, ifnull(estoque.qtde_estoque,0) qtde_estoque, ifnull(vendido.qtde_vendido,0) qtde_vendido, '
    sql += ' ifnull(round(((ifnull(vendido.qtde_vendido,0)/(ifnull(estoque.qtde_estoque,0) + ifnull(vendido.qtde_vendido,0))) * 100),1),0) percentual, '
    sql += ' ifnull(estoque.soma_estoque,0) soma_estoque, ifnull(vendido.soma_vendido,0) soma_vendido, comprado.valor total_comprado, '
    sql += ' (ifnull(vendido.soma_vendido,0) - comprado.valor) lucro, '
    sql += ' round(((ifnull(vendido.soma_vendido,0) - ifnull(comprado.valor,0)) / ifnull(comprado.valor,0) * 100),1) percentual_valor '
    sql += '    from '
    sql += '    (select id, descricao from marcas) m '
    sql += '    left outer join '
    sql += '    (select marca_id id, ifnull(sum(valor_minimo),0) valor '
    sql += '    from produtos '
    sql += '    group by marca_id) comprado '
    sql += '    on comprado.id = m.id '
    sql += '    left outer join '
    sql += '    (select m.id, m.descricao, sum(p.valor_venda) soma_estoque, count(*) qtde_estoque '
    sql += '    from produtos p, marcas m where p.venda_id is null and p.marca_id = m.id group by m.id) estoque '
    sql += '    on comprado.id = estoque.id '
    sql += '    left outer join '
    sql += '    (select m.id, m.descricao, sum(p.valor_vendido) soma_vendido, count(*) qtde_vendido '
    sql += '    from produtos p, marcas m where p.venda_id is not null and p.marca_id = m.id group by m.id) vendido '
    sql += '    on comprado.id = vendido.id '
    sql += '    order by lucro desc, percentual desc, soma_vendido desc '

    find_by_sql(sql)
  end
  
  private
  
  def sem_produtos
    return if produtos.empty?
      errors[:base] << "Esta marca tem produtos(s) associado(s): #{produtos.size} registro(s)!"
     false
  end
 
end
