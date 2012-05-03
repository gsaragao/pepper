class CreateCores < ActiveRecord::Migration
  def change
    create_table :cores do |t|
      t.string :descricao
      t.text :observacao

      t.timestamps
    end
    add_index :cores, :descricao, :unique => true
  end
end
