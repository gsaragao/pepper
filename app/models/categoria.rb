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
  
  private

   def no_children
     return if children.empty?
      errors[:base] << "Esta categoria tem categoria(s) associada(s): #{children.size} registro(s)!"
     false
   end
  
end