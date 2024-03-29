# encoding: UTF-8
class Vendedor < ActiveRecord::Base
  belongs_to :cidade
  has_many :vendas
  before_destroy :sem_vendas
  attr_accessible :cidade_id, :email, :endereco, :nome, :telefone, :observacao, :default
  validates_presence_of :nome
  validates_uniqueness_of :nome, :scope => :cidade_id, :message => "Este registro já foi cadastrado para esta cidade!"
  validates_format_of :email, 
                      :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i, 
                      :message    => 'Inválido!',
                      :allow_blank => true                    
  
  self.per_page = 10
  DEFAULT = 1

  def self.pesquisar(obj, page)
    nome = obj ? obj[:nome] : ""
    if (obj && obj[:cidade_id]) 
      includes(:cidade).where("vendedores.nome like ? and vendedores.cidade_id = ?", "%#{nome}%", obj[:cidade_id]).paginate(:page => page).order("nome")
    else
      includes(:cidade).where("vendedores.nome like ?", "%#{nome}%").paginate(:page => page).order("nome")
    end    
  end
  
  private
  
  def sem_vendas
    return if vendas.empty?
      errors[:base] << "Este vendedor tem venda(s) associada(s): #{vendas.size} registro(s)!"
     false
  end
  
end
