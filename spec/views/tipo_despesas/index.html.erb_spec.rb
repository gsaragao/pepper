require 'spec_helper'

describe "tipo_despesas/index" do
  before(:each) do
    assign(:tipo_despesas, [
      stub_model(TipoDespesa,
        :descricao => "Descricao",
        :observacao => "MyText"
      ),
      stub_model(TipoDespesa,
        :descricao => "Descricao",
        :observacao => "MyText"
      )
    ])
  end

  it "renders a list of tipo_despesas" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Descricao".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
