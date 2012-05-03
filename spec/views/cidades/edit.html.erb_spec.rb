require 'spec_helper'

describe "cidades/edit" do
  before(:each) do
    @cidade = assign(:cidade, stub_model(Cidade,
      :nome => "MyString"
    ))
  end

  it "renders the edit cidade form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => cidades_path(@cidade), :method => "post" do
      assert_select "input#cidade_nome", :name => "cidade[nome]"
    end
  end
end
