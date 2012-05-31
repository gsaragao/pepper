class CreatePagamentoVendas < ActiveRecord::Migration
  def change
    create_table :pagamento_vendas do |t|
      t.integer :forma_pagamento
      t.integer :parcela
      t.decimal :valor, :precision => 13, :scale => 2
      t.date :data
      t.references :venda

      t.timestamps
    end
    add_index :pagamento_vendas, :venda_id
    add_foreign_key(:pagamento_vendas, :vendas)
  end

end