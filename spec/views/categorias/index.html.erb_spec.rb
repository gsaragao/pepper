require 'spec_helper'

describe "categorias/index" do
  before(:each) do
    assign(:categorias, [
      stub_model(Categoria,
        :descricao => "Descricao",
        :id_pai => 1
      ),
      stub_model(Categoria,
        :descricao => "Descricao",
        :id_pai => 1
      )
    ])
  end

  it "renders a list of categorias" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Descricao".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
