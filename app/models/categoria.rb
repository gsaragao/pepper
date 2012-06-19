# encoding: UTF-8
class Categoria < ActiveRecord::Base
  has_many :children, :class_name => "Categoria", :foreign_key => "id_pai"
	belongs_to :father, :class_name => "Categoria", :foreign_key => "id_pai"
  before_destroy :no_children
  attr_accessible :descricao, :id_pai, :observacao
	validates_presence_of :descricao
  self.per_page = 10
	
	def rec
	  rt = ""
	  
	  if (father)
	    rt = father.rec + " > " + self.descricao
	  else
	    rt = self.descricao   
	  end
	  rt  
	end
  
  def self.pesquisar(obj, page)
    
    descricao = obj ? obj[:descricao] : ""
    
    if (obj && obj[:id_pai]) 
      where("categorias.descricao like ? and categorias.id_pai = ?", "%#{descricao}%", obj[:id_pai]).paginate(:page => page).order("descricao")
    else
      where("categorias.descricao like ?", "%#{descricao}%").paginate(:page => page).order("descricao")
    end
  end
  
  def self.relacao_categoria_vendas
    
     sql  = ' select c.descricao, vendido.valor valor_vendido, vendido.qtde qtde_vendido, estoque.valor valor_estoque, estoque.qtde qtde_estoque '
     sql += ' from categorias c  '
     sql += ' left outer join ( '
     sql += ' select categoria_id, sum(valor_vendido) valor, count(*) qtde from produtos where venda_id is not null group by categoria_id) vendido '
     sql += ' on vendido.categoria_id = c.id '
     sql += ' left outer join  '
     sql += ' (select categoria_id, sum(valor_venda) valor, count(*) qtde from produtos where venda_id is null group by categoria_id) estoque '
     sql += ' on estoque.categoria_id = c.id  '
     sql += ' order by valor_vendido desc, qtde_vendido desc '
    
     find_by_sql(sql)
  end
  
  private

   def no_children
     return if children.empty?
      errors[:base] << "Esta categoria tem categoria(s) associada(s): #{children.size} registro(s)!"
     false
   end
  
end