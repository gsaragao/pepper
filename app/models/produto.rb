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
  before_destroy :sem_vendas
  has_attached_file :foto, :styles => { :pequeno => "200x230>" }
  attr_accessor :acao, :quantidade, :lista
  validates_presence_of :descricao, :categoria_id, :compra_id, :valor_compra, :fornecedor_id, :marca_id
  #validate :valida_quantidade_maior_que_zero, :unless => "quantidade.nil?"
  validates_uniqueness_of :codigo_interno, :message => " já foi cadastrado!"
  attr_accessible :codigo_fabricante, :codigo_interno, :descricao, :foto_file_name, :categoria_id,:compra_id, :cor_id, :venda_id, 
  :margem_lucro, :observacao, :valor_compra, :valor_minimo, :valor_venda, :fornecedor_id, :tamanho_id, :marca_id, :foto, :quantidade,
  :valor_vendido, :lista
  
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
  ESTOQUE = 'ES'
  VENDIDO = 'VD'
  COPY = '1'

  def valor_formatado
    number_to_currency(self.valor_venda)
  end
  
  def pesquisar(page)
    query = Produto.paginate(:conditions => conditions, :page => page).order("id desc")
    query = query.where("venda_id is null") if lista == Produto::ESTOQUE
    query = query.where("venda_id is not null") if lista == Produto::VENDIDO
    query
  end
  
  def self.qtde_cadastrados_vendidos
     retorno = []
     retorno[0] = where("venda_id is null").count
     retorno[1] = where("venda_id is not null").count
     
     cont = Produto.count
     perc_e = 0
     perc_v = 0
     
     if (cont > 0)
        perc_e = ((retorno[0].to_f / cont.to_f) * 100).round(1)
        perc_v = ((retorno[1].to_f / cont.to_f) * 100).round(1)
     end
     
     retorno[2] = perc_e
     retorno[3] = perc_v
     retorno[4] = cont
     retorno
  end
  
  private
  
  def descricao_conditions
    ["produtos.descricao LIKE ?", "%#{descricao}%"] unless descricao.blank?
  end

  def compra_id_conditions
    ["produtos.compra_id = ?", compra_id] unless compra_id.blank?
  end
    
  def marca_id_conditions
    ["produtos.marca_id = ?", marca_id] unless marca_id.blank?
  end  
    
  def codigo_interno_conditions
    ["produtos.codigo_interno = ?", codigo_interno] unless codigo_interno.blank?
  end

  def conditions
    [conditions_clauses.join(' AND '), *conditions_options]
  end

  def conditions_clauses
    conditions_parts.map { |condition| condition.first }
  end

  def conditions_options
    conditions_parts.map { |condition| condition[1..-1] }.flatten
  end

  def conditions_parts
    private_methods(false).grep(/_conditions$/).map { |m| send(m) }.compact
  end
  
  def sem_vendas
    return if venda_id.nil?
      data = I18n.l(venda.data)
      errors[:base] << "Produto associado a venda do dia #{data} do cliente #{venda.cliente.nome}!"
     false
  end


end
