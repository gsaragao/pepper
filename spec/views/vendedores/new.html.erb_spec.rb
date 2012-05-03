require 'spec_helper'

describe "vendedores/new" do
  before(:each) do
    assign(:vendedor, stub_model(Vendedor,
      :nome => "MyString",
      :email => "MyString",
      :telefone => "MyString",
      :cidade => nil,
      :endereco => "MyText",
      :observacao => "MyText"
    ).as_new_record)
  end

  it "renders new vendedor form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => vendedores_path, :method => "post" do
      assert_select "input#vendedor_nome", :name => "vendedor[nome]"
      assert_select "input#vendedor_email", :name => "vendedor[email]"
      assert_select "input#vendedor_telefone", :name => "vendedor[telefone]"
      assert_select "input#vendedor_cidade", :name => "vendedor[cidade]"
      assert_select "textarea#vendedor_endereco", :name => "vendedor[endereco]"
      assert_select "textarea#vendedor_observacao", :name => "vendedor[observacao]"
    end
  end
end
