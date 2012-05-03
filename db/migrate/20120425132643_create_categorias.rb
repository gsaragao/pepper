class CreateCategorias < ActiveRecord::Migration
  def change
    create_table :categorias do |t|
      t.string :descricao
      t.text :observacao
      t.integer :id_pai

      t.timestamps
    end
    add_index :categorias, :descricao, :unique => true
    add_foreign_key(:categorias, :categorias, :column => 'id_pai')
  end
end
