class AddForeignKeyToVendas < ActiveRecord::Migration
  def change
    add_foreign_key(:vendas, :clientes)
    add_foreign_key(:vendas, :vendedores)
  end
end
