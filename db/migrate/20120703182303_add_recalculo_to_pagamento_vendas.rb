class AddRecalculoToPagamentoVendas < ActiveRecord::Migration
  def change
    add_column :pagamento_vendas, :recalculo, :decimal, :precision => 13, :scale => 2
  end
end
