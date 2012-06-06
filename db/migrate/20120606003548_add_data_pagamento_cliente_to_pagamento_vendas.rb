class AddDataPagamentoClienteToPagamentoVendas < ActiveRecord::Migration
  def change
    add_column :pagamento_vendas, :data_pagamento_cliente, :date
  end
end
