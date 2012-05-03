require 'spec_helper'

describe "cidades/show" do
  before(:each) do
    @cidade = assign(:cidade, stub_model(Cidade,
      :nome => "Nome"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Nome/)
  end
end
