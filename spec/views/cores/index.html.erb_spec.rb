require 'spec_helper'

describe "cores/index" do
  before(:each) do
    assign(:cores, [
      stub_model(Cor,
        :descricao => "Descricao",
        :observacao => "MyText"
      ),
      stub_model(Cor,
        :descricao => "Descricao",
        :observacao => "MyText"
      )
    ])
  end

  it "renders a list of cores" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Descricao".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
