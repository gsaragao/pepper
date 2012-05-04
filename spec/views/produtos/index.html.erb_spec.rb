require 'spec_helper'

describe "produtos/index" do
  before(:each) do
    assign(:produtos, [
      stub_model(Produto,
        :descricao => "Descricao",
        :codigo_interno => "Codigo Interno",
        :codigo_fabricante => "Codigo Fabricante",
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
        :foto_file_name => "Foto File Name",
        :foto_content_type => "Foto Content Type",
        :foto_file_size => 1
      ),
      stub_model(Produto,
        :descricao => "Descricao",
        :codigo_interno => "Codigo Interno",
        :codigo_fabricante => "Codigo Fabricante",
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
        :foto_file_name => "Foto File Name",
        :foto_content_type => "Foto Content Type",
        :foto_file_size => 1
      )
    ])
  end

  it "renders a list of produtos" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Descricao".to_s, :count => 2
    assert_select "tr>td", :text => "Codigo Interno".to_s, :count => 2
    assert_select "tr>td", :text => "Codigo Fabricante".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Foto File Name".to_s, :count => 2
    assert_select "tr>td", :text => "Foto Content Type".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
