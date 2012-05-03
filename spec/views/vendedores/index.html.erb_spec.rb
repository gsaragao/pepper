require 'spec_helper'

describe "vendedores/index" do
  before(:each) do
    assign(:vendedores, [
      stub_model(Vendedor,
        :nome => "Nome",
        :email => "Email",
        :telefone => "Telefone",
        :cidade => nil,
        :endereco => "MyText",
        :observacao => "MyText"
      ),
      stub_model(Vendedor,
        :nome => "Nome",
        :email => "Email",
        :telefone => "Telefone",
        :cidade => nil,
        :endereco => "MyText",
        :observacao => "MyText"
      )
    ])
  end

  it "renders a list of vendedores" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Nome".to_s, :count => 2
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    assert_select "tr>td", :text => "Telefone".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
