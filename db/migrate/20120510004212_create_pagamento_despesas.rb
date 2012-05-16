class CreatePagamentoDespesas < ActiveRecord::Migration
  def change
    create_table :pagamento_despesas do |t|
      t.integer :forma_pagamento
      t.integer :parcela
      t.decimal :valor, :precision => 13, :scale => 2
      t.date :data
      t.references :despesa

      t.timestamps
    end
    add_index :pagamento_despesas, :despesa_id
    add_foreign_key(:pagamento_despesas, :despesas)
  end
end