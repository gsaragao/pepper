class CreateCompras < ActiveRecord::Migration
  def change
    create_table :compras do |t|
      t.string :descricao
      t.date :data
      t.text :observacao
      t.integer :default

      t.timestamps
    end
  end
end
