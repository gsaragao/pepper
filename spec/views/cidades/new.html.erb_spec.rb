require 'spec_helper'

describe "cidades/new" do
  before(:each) do
    assign(:cidade, stub_model(Cidade,
      :nome => "MyString"
    ).as_new_record)
  end

  it "renders new cidade form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => cidades_path, :method => "post" do
      assert_select "input#cidade_nome", :name => "cidade[nome]"
    end
  end
end
