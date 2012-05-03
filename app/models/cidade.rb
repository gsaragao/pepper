# encoding: UTF-8
class Cidade < ActiveRecord::Base
  has_many :clientes
  has_many :fornecedores
  before_destroy :no_clientes_fornecedores
  attr_accessible :nome
  validates_presence_of :nome
  validates_uniqueness_of :nome, :message => "Este registro já foi cadastrado!"
  
  self.per_page = 10

  def self.pesquisar(obj, page)
    nome = obj ? obj[:nome] : ""
    where("cidades.nome like ?", "%#{nome}%").paginate(:page => page).order("nome")
  end
  
  private

   def no_clientes_fornecedores
     return if (clientes.empty? && fornecedores.empty?) 
        errors[:base] << "Esta cidade tem cliente(s) e/ou fornecedores(s) associado(s): #{clientes.size + fornecedores.size} registro(s)!"
     false
   end
  
end
