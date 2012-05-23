require 'spec_helper'

describe "vendas/show" do
  before(:each) do
    @venda = assign(:venda, stub_model(Venda,
      :cliente => nil,
      :vendedor => nil,
      :observacao => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    rendered.should match(//)
    rendered.should match(/MyText/)
  end
end
