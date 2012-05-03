class CreateMarcas < ActiveRecord::Migration
  def change
    create_table :marcas do |t|
      t.string :descricao
      t.text :observacao

      t.timestamps
    end
    add_index :marcas, :descricao, :unique => true
  end
end
