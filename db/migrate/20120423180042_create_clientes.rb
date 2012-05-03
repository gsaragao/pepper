class CreateClientes < ActiveRecord::Migration
  def change
    create_table :clientes do |t|
      t.string :nome
      t.string :email
      t.string :telefone
      t.references :cidade
      t.text :endereco
      t.text :observacao

      t.timestamps
    end
    add_index :clientes, [:nome, :cidade_id], :unique => true
    add_index :clientes, :cidade_id
    add_foreign_key(:clientes, :cidades)
  end
end
