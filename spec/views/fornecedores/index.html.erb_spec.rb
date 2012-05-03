require 'spec_helper'

describe "fornecedores/index" do
  before(:each) do
    assign(:fornecedores, [
      stub_model(Fornecedor,
        :nome => "Nome",
        :telefone => "Telefone",
        :email => "Email",
        :cidade => nil,
        :endereco => "MyText",
        :observacao => "MyText"
      ),
      stub_model(Fornecedor,
        :nome => "Nome",
        :telefone => "Telefone",
        :email => "Email",
        :cidade => nil,
        :endereco => "MyText",
        :observacao => "MyText"
      )
    ])
  end

  it "renders a list of fornecedores" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Nome".to_s, :count => 2
    assert_select "tr>td", :text => "Telefone".to_s, :count => 2
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
