require 'spec_helper'

describe "vendedores/show" do
  before(:each) do
    @vendedor = assign(:vendedor, stub_model(Vendedor,
      :nome => "Nome",
      :email => "Email",
      :telefone => "Telefone",
      :cidade => nil,
      :endereco => "MyText",
      :observacao => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Nome/)
    rendered.should match(/Email/)
    rendered.should match(/Telefone/)
    rendered.should match(//)
    rendered.should match(/MyText/)
    rendered.should match(/MyText/)
  end
end
