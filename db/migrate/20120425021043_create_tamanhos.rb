class CreateTamanhos < ActiveRecord::Migration
  def change
    create_table :tamanhos do |t|
      t.string :descricao
      t.integer :default
      t.text :observacao

      t.timestamps
    end
    add_index :tamanhos, :descricao, :unique => true
  end
end
