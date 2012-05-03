class CreateDespesas < ActiveRecord::Migration
  def change
    create_table :despesas do |t|
      t.string :descricao
      t.references :compra
      t.references :tipo_despesa
      t.references :fornecedor
      t.date :data
      t.decimal :valor, :precision => 13, :scale => 2
      t.text :observacao

      t.timestamps
    end
    add_index :despesas, :compra_id
    add_index :despesas, :tipo_despesa_id
    add_index :despesas, :fornecedor_id
    add_foreign_key(:despesas, :compras)
    add_foreign_key(:despesas, :tipo_despesas)
    add_foreign_key(:despesas, :fornecedores)
  end
end
