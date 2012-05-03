require 'spec_helper'

describe "despesas/index" do
  before(:each) do
    assign(:despesas, [
      stub_model(Despesa,
        :compra => nil,
        :tipo_despesa => nil,
        :valor => "9.99"
      ),
      stub_model(Despesa,
        :compra => nil,
        :tipo_despesa => nil,
        :valor => "9.99"
      )
    ])
  end

  it "renders a list of despesas" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
  end
end
