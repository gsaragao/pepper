require 'spec_helper'

describe "cores/edit" do
  before(:each) do
    @cor = assign(:cor, stub_model(Cor,
      :descricao => "MyString",
      :observacao => "MyText"
    ))
  end

  it "renders the edit cor form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => cores_path(@cor), :method => "post" do
      assert_select "input#cor_descricao", :name => "cor[descricao]"
      assert_select "textarea#cor_observacao", :name => "cor[observacao]"
    end
  end
end
