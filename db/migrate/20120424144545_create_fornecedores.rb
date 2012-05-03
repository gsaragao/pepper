class CreateFornecedores < ActiveRecord::Migration
  def change
    create_table :fornecedores do |t|
      t.string :nome
      t.string :telefone
      t.string :email
      t.references :cidade
      t.text :endereco
      t.text :observacao

      t.timestamps
    end
    add_index :fornecedores, :cidade_id
    add_index :fornecedores, [:nome, :cidade_id], :unique => true
  end
end
