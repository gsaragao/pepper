require 'spec_helper'

describe "marcas/index" do
  before(:each) do
    assign(:marcas, [
      stub_model(Marca,
        :descricao => "Descricao",
        :observacao => "MyText"
      ),
      stub_model(Marca,
        :descricao => "Descricao",
        :observacao => "MyText"
      )
    ])
  end

  it "renders a list of marcas" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Descricao".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
