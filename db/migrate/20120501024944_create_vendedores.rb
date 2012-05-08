class CreateVendedores < ActiveRecord::Migration
  def change
    create_table :vendedores do |t|
      t.string :nome
      t.string :email
      t.string :telefone
      t.references :cidade
      t.text :endereco
      t.integer :default
      t.text :observacao

      t.timestamps
    end
    add_index :vendedores, [:nome, :cidade_id], :unique => true
    add_index :vendedores, :cidade_id
    add_foreign_key(:vendedores, :cidades)
  end
end
