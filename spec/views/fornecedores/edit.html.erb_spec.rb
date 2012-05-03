require 'spec_helper'

describe "fornecedores/edit" do
  before(:each) do
    @fornecedor = assign(:fornecedor, stub_model(Fornecedor,
      :nome => "MyString",
      :telefone => "MyString",
      :email => "MyString",
      :cidade => nil,
      :endereco => "MyText",
      :observacao => "MyText"
    ))
  end

  it "renders the edit fornecedor form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => fornecedores_path(@fornecedor), :method => "post" do
      assert_select "input#fornecedor_nome", :name => "fornecedor[nome]"
      assert_select "input#fornecedor_telefone", :name => "fornecedor[telefone]"
      assert_select "input#fornecedor_email", :name => "fornecedor[email]"
      assert_select "input#fornecedor_cidade", :name => "fornecedor[cidade]"
      assert_select "textarea#fornecedor_endereco", :name => "fornecedor[endereco]"
      assert_select "textarea#fornecedor_observacao", :name => "fornecedor[observacao]"
    end
  end
end
