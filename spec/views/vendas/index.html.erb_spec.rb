require 'spec_helper'

describe "vendas/index" do
  before(:each) do
    assign(:vendas, [
      stub_model(Venda,
        :cliente => nil,
        :vendedor => nil,
        :observacao => "MyText"
      ),
      stub_model(Venda,
        :cliente => nil,
        :vendedor => nil,
        :observacao => "MyText"
      )
    ])
  end

  it "renders a list of vendas" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
