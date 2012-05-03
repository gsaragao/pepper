class CreateCidades < ActiveRecord::Migration
  def change
    create_table :cidades do |t|
      t.string :nome

      t.timestamps
    end
    add_index :cidades, :nome, :unique => true
  end
end
