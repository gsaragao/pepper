require 'spec_helper'

describe "produtos/show" do
  before(:each) do
    @produto = assign(:produto, stub_model(Produto,
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
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Descricao/)
    rendered.should match(/Codigo Interno/)
    rendered.should match(/Codigo Fabricante/)
    rendered.should match(//)
    rendered.should match(//)
    rendered.should match(//)
    rendered.should match(//)
    rendered.should match(//)
    rendered.should match(//)
    rendered.should match(/9.99/)
    rendered.should match(/9.99/)
    rendered.should match(/9.99/)
    rendered.should match(/9.99/)
    rendered.should match(/MyText/)
    rendered.should match(/Foto File Name/)
    rendered.should match(/Foto Content Type/)
    rendered.should match(/1/)
  end
end
