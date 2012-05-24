class CreateVendas < ActiveRecord::Migration
  def change
    create_table :vendas do |t|
      t.references :cliente
      t.references :vendedor
      t.date :data
      t.text :observacao

      t.timestamps
    end
    add_index :vendas, :cliente_id
    add_index :vendas, :vendedor_id
  end
end
