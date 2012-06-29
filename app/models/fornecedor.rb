# encoding: UTF-8
class Fornecedor < ActiveRecord::Base
  has_many :produtos
  before_destroy :sem_produtos
  belongs_to :cidade
  attr_accessible :email, :endereco, :nome, :observacao, :telefone, :cidade_id
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
      where("fornecedores.nome like ? and fornecedores.cidade_id = ?", "%#{nome}%", obj[:cidade_id]).paginate(:page => page).order("nome")
    else
      where("fornecedores.nome like ?", "%#{nome}%").paginate(:page => page).order("nome")
    end    
  end
  
  private
  
  def sem_produtos
    return if produtos.empty?
      errors[:base] << "Este fornecedor tem produtos(s) associado(s): #{produtos.size} registro(s)!"
     false
  end
  
end
