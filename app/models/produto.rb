# encoding: UTF-8
class Produto < ActiveRecord::Base
  include ActionView::Helpers::NumberHelper
  belongs_to :categoria
  belongs_to :fornecedor
  belongs_to :compra
  belongs_to :marca
  belongs_to :cor
  belongs_to :tamanho
  belongs_to :venda
  has_attached_file :foto, :styles => { :pequeno => "200x230>" }
  attr_accessor :acao, :quantidade
  validates_presence_of :descricao, :categoria_id, :compra_id, :valor_compra, :fornecedor_id, :marca_id
  #validate :valida_quantidade_maior_que_zero, :unless => "quantidade.nil?"
  validates_uniqueness_of :codigo_interno, :message => " já foi cadastrado!"
  attr_accessible :codigo_fabricante, :codigo_interno, :descricao, :foto_file_name, :categoria_id,:compra_id, :cor_id, :venda_id, 
  :margem_lucro, :observacao, :valor_compra, :valor_minimo, :valor_venda, :fornecedor_id, :tamanho_id, :marca_id, :foto, :quantidade
  
  validates_attachment_content_type :foto, 
                                    :content_type => ['image/jpg',
                                                      'image/jpeg', 
                                                      'image/png', 
                                                      'image/gif',
                                                      'image/pjpeg', 
                                                      'image/x-png' 
                                                      ], 
                                    :message => I18n.t('produto.foto_valida.tipo')
  
   validates_attachment_size :foto, :less_than=> 200.kilobytes,   
                                      :message => I18n.t('produto.foto_valida.tamanho')
  
  self.per_page = 10
  COPY = '1'
  
  def self.pesquisar(obj, page)
    descricao = obj ? obj[:descricao] : ""
    #if (obj && obj[:cidade_id]) 
    #  where("clientes.nome like ? and clientes.cidade_id = ?", "%#{nome}%", obj[:cidade_id]).paginate(:page => page).order("nome")
    #else
      where("produtos.descricao like ?", "%#{descricao}%").paginate(:page => page).order("id desc")
  #  end    
  end
  
  def valor_formatado
    number_to_currency(self.valor_venda)
  end
  
  #def valida_quantidade_maior_que_zero
  #   errors.add :quantidade, "deve ser maior que zero!" if quantidade.to_i <= 0
  #end
  
end
