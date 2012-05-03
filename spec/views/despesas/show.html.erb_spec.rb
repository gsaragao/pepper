require 'spec_helper'

describe "despesas/show" do
  before(:each) do
    @despesa = assign(:despesa, stub_model(Despesa,
      :compra => nil,
      :tipo_despesa => nil,
      :valor => "9.99"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    rendered.should match(//)
    rendered.should match(/9.99/)
  end
end
