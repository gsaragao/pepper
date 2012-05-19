# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120510004212) do

  create_table "categorias", :force => true do |t|
    t.string   "descricao"
    t.text     "observacao"
    t.integer  "id_pai"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "categorias", ["descricao"], :name => "index_categorias_on_descricao", :unique => true
  add_index "categorias", ["id_pai"], :name => "categorias_id_pai_fk"

  create_table "cidades", :force => true do |t|
    t.string   "nome"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "cidades", ["nome"], :name => "index_cidades_on_nome", :unique => true

  create_table "clientes", :force => true do |t|
    t.string   "nome"
    t.string   "email"
    t.string   "telefone"
    t.integer  "cidade_id"
    t.text     "endereco"
    t.text     "observacao"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "clientes", ["cidade_id"], :name => "index_clientes_on_cidade_id"
  add_index "clientes", ["nome", "cidade_id"], :name => "index_clientes_on_nome_and_cidade_id", :unique => true

  create_table "compras", :force => true do |t|
    t.string   "descricao"
    t.date     "data"
    t.text     "observacao"
    t.integer  "default"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "cores", :force => true do |t|
    t.string   "descricao"
    t.text     "observacao"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "cores", ["descricao"], :name => "index_cores_on_descricao", :unique => true

  create_table "despesas", :force => true do |t|
    t.string   "descricao"
    t.integer  "compra_id"
    t.integer  "tipo_despesa_id"
    t.integer  "fornecedor_id"
    t.date     "data"
    t.decimal  "valor",           :precision => 13, :scale => 2
    t.text     "observacao"
    t.datetime "created_at",                                     :null => false
    t.datetime "updated_at",                                     :null => false
  end

  add_index "despesas", ["compra_id"], :name => "index_despesas_on_compra_id"
  add_index "despesas", ["fornecedor_id"], :name => "index_despesas_on_fornecedor_id"
  add_index "despesas", ["tipo_despesa_id"], :name => "index_despesas_on_tipo_despesa_id"

  create_table "fornecedores", :force => true do |t|
    t.string   "nome"
    t.string   "telefone"
    t.string   "email"
    t.integer  "cidade_id"
    t.text     "endereco"
    t.text     "observacao"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "fornecedores", ["cidade_id"], :name => "index_fornecedores_on_cidade_id"
  add_index "fornecedores", ["nome", "cidade_id"], :name => "index_fornecedores_on_nome_and_cidade_id", :unique => true

  create_table "marcas", :force => true do |t|
    t.string   "descricao"
    t.text     "observacao"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "marcas", ["descricao"], :name => "index_marcas_on_descricao", :unique => true

  create_table "pagamento_despesas", :force => true do |t|
    t.integer  "forma_pagamento"
    t.integer  "parcela"
    t.decimal  "valor",           :precision => 13, :scale => 2
    t.date     "data"
    t.integer  "despesa_id"
    t.datetime "created_at",                                     :null => false
    t.datetime "updated_at",                                     :null => false
  end

  add_index "pagamento_despesas", ["despesa_id"], :name => "index_pagamento_despesas_on_despesa_id"

  create_table "produtos", :force => true do |t|
    t.string   "descricao"
    t.string   "codigo_interno"
    t.string   "codigo_fabricante"
    t.integer  "categoria_id"
    t.integer  "fornecedor_id"
    t.integer  "compra_id"
    t.integer  "marca_id"
    t.integer  "cor_id"
    t.integer  "tamanho_id"
    t.decimal  "valor_compra",      :precision => 13, :scale => 2
    t.decimal  "valor_venda",       :precision => 13, :scale => 2
    t.decimal  "valor_minimo",      :precision => 13, :scale => 2
    t.decimal  "margem_lucro",      :precision => 4,  :scale => 1
    t.text     "observacao"
    t.string   "foto_file_name"
    t.string   "foto_content_type"
    t.integer  "foto_file_size"
    t.datetime "foto_updated_at"
    t.datetime "created_at",                                       :null => false
    t.datetime "updated_at",                                       :null => false
  end

  add_index "produtos", ["categoria_id"], :name => "index_produtos_on_categoria_id"
  add_index "produtos", ["codigo_interno"], :name => "index_produtos_on_codigo_interno", :unique => true
  add_index "produtos", ["compra_id"], :name => "index_produtos_on_compra_id"
  add_index "produtos", ["cor_id"], :name => "index_produtos_on_cor_id"
  add_index "produtos", ["fornecedor_id"], :name => "index_produtos_on_fornecedor_id"
  add_index "produtos", ["marca_id"], :name => "index_produtos_on_marca_id"
  add_index "produtos", ["tamanho_id"], :name => "index_produtos_on_tamanho_id"

  create_table "tamanhos", :force => true do |t|
    t.string   "descricao"
    t.integer  "default"
    t.text     "observacao"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "tamanhos", ["descricao"], :name => "index_tamanhos_on_descricao", :unique => true

  create_table "tipo_despesas", :force => true do |t|
    t.string   "descricao"
    t.integer  "retorno",    :default => 0
    t.text     "observacao"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "tipo_despesas", ["descricao"], :name => "index_tipo_despesas_on_descricao", :unique => true

  create_table "vendedores", :force => true do |t|
    t.string   "nome"
    t.string   "email"
    t.string   "telefone"
    t.integer  "cidade_id"
    t.text     "endereco"
    t.integer  "default"
    t.text     "observacao"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "vendedores", ["cidade_id"], :name => "index_vendedores_on_cidade_id"
  add_index "vendedores", ["nome", "cidade_id"], :name => "index_vendedores_on_nome_and_cidade_id", :unique => true

  add_foreign_key "categorias", "categorias", :name => "categorias_id_pai_fk", :column => "id_pai"

  add_foreign_key "clientes", "cidades", :name => "clientes_cidade_id_fk"

  add_foreign_key "despesas", "compras", :name => "despesas_compra_id_fk"
  add_foreign_key "despesas", "fornecedores", :name => "despesas_fornecedor_id_fk"
  add_foreign_key "despesas", "tipo_despesas", :name => "despesas_tipo_despesa_id_fk"

  add_foreign_key "pagamento_despesas", "despesas", :name => "pagamento_despesas_despesa_id_fk"

  add_foreign_key "produtos", "categorias", :name => "produtos_categoria_id_fk"
  add_foreign_key "produtos", "compras", :name => "produtos_compra_id_fk"
  add_foreign_key "produtos", "cores", :name => "produtos_cor_id_fk"
  add_foreign_key "produtos", "fornecedores", :name => "produtos_fornecedor_id_fk"
  add_foreign_key "produtos", "marcas", :name => "produtos_marca_id_fk"
  add_foreign_key "produtos", "tamanhos", :name => "produtos_tamanho_id_fk"

  add_foreign_key "vendedores", "cidades", :name => "vendedores_cidade_id_fk"

end
