# encoding: UTF-8
class Cliente < ActiveRecord::Base
  belongs_to :cidade
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
      where("clientes.nome like ? and clientes.cidade_id = ?", "%#{nome}%", obj[:cidade_id]).paginate(:page => page).order("nome")
    else
      where("clientes.nome like ?", "%#{nome}%").paginate(:page => page).order("nome")
    end    
  end
end
