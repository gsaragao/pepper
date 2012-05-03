require 'spec_helper'

describe "fornecedores/show" do
  before(:each) do
    @fornecedor = assign(:fornecedor, stub_model(Fornecedor,
      :nome => "Nome",
      :telefone => "Telefone",
      :email => "Email",
      :cidade => nil,
      :endereco => "MyText",
      :observacao => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Nome/)
    rendered.should match(/Telefone/)
    rendered.should match(/Email/)
    rendered.should match(//)
    rendered.should match(/MyText/)
    rendered.should match(/MyText/)
  end
end
