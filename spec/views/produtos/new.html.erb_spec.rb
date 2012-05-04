require 'spec_helper'

describe "produtos/new" do
  before(:each) do
    assign(:produto, stub_model(Produto,
      :descricao => "MyString",
      :codigo_interno => "MyString",
      :codigo_fabricante => "MyString",
      :categoria => nil,
      :fornecedor => nil,
      :compra => nil,
      :marca => nil,
      :cor => nil,
      :tamanho => nil,
      :valor_compra => "9.99",
      :valor_venda => "9.99",
      :valor_minimo => "9.99",
      :margem_lucro => "9.99",
      :observacao => "MyText",
      :foto_file_name => "MyString",
      :foto_content_type => "MyString",
      :foto_file_size => 1
    ).as_new_record)
  end

  it "renders new produto form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => produtos_path, :method => "post" do
      assert_select "input#produto_descricao", :name => "produto[descricao]"
      assert_select "input#produto_codigo_interno", :name => "produto[codigo_interno]"
      assert_select "input#produto_codigo_fabricante", :name => "produto[codigo_fabricante]"
      assert_select "input#produto_categoria", :name => "produto[categoria]"
      assert_select "input#produto_fornecedor", :name => "produto[fornecedor]"
      assert_select "input#produto_compra", :name => "produto[compra]"
      assert_select "input#produto_marca", :name => "produto[marca]"
      assert_select "input#produto_cor", :name => "produto[cor]"
      assert_select "input#produto_tamanho", :name => "produto[tamanho]"
      assert_select "input#produto_valor_compra", :name => "produto[valor_compra]"
      assert_select "input#produto_valor_venda", :name => "produto[valor_venda]"
      assert_select "input#produto_valor_minimo", :name => "produto[valor_minimo]"
      assert_select "input#produto_margem_lucro", :name => "produto[margem_lucro]"
      assert_select "textarea#produto_observacao", :name => "produto[observacao]"
      assert_select "input#produto_foto_file_name", :name => "produto[foto_file_name]"
      assert_select "input#produto_foto_content_type", :name => "produto[foto_content_type]"
      assert_select "input#produto_foto_file_size", :name => "produto[foto_file_size]"
    end
  end
end
