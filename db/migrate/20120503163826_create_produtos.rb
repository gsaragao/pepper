class CreateProdutos < ActiveRecord::Migration
  def change
    create_table :produtos do |t|
      t.string :descricao
      t.string :codigo_interno
      t.string :codigo_fabricante
      t.references :categoria
      t.references :fornecedor
      t.references :compra
      t.references :marca
      t.references :cor
      t.references :tamanho
      t.references :venda
      t.decimal :valor_compra, :precision => 13, :scale => 2
      t.decimal :valor_venda, :precision => 13, :scale => 2
      t.decimal :valor_minimo, :precision => 13, :scale => 2
      t.decimal :valor_vendido, :precision => 13, :scale => 2
      t.decimal :margem_lucro, :precision => 4, :scale => 1
      t.text :observacao
      t.string :foto_file_name
      t.string :foto_content_type
      t.integer :foto_file_size
      t.datetime :foto_updated_at

      t.timestamps
    end
    add_index :produtos, :codigo_interno, :unique => true
    add_index :produtos, :categoria_id
    add_index :produtos, :fornecedor_id
    add_index :produtos, :compra_id
    add_index :produtos, :marca_id
    add_index :produtos, :cor_id
    add_index :produtos, :tamanho_id
    add_index :produtos, :venda_id
    add_foreign_key(:produtos, :categorias)
    add_foreign_key(:produtos, :fornecedores)
    add_foreign_key(:produtos, :compras)
    add_foreign_key(:produtos, :marcas)
    add_foreign_key(:produtos, :cores)
    add_foreign_key(:produtos, :tamanhos)
    add_foreign_key(:produtos, :vendas)
  end
end
