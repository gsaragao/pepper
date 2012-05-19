class CreateTipoDespesas < ActiveRecord::Migration
  def change
    create_table :tipo_despesas do |t|
      t.string :descricao
      t.integer :retorno, :default => 0
      t.text :observacao

      t.timestamps
    end
    add_index :tipo_despesas, :descricao, :unique => true
  end
end
