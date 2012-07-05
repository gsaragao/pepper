class AddValorPagoToPagamentoVendas < ActiveRecord::Migration
  def change
    add_column :pagamento_vendas, :valor_pago, :decimal, :precision => 13, :scale => 2
  end
end
