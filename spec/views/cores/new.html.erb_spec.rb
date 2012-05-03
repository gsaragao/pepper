require 'spec_helper'

describe "cores/new" do
  before(:each) do
    assign(:cor, stub_model(Cor,
      :descricao => "MyString",
      :observacao => "MyText"
    ).as_new_record)
  end

  it "renders new cor form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => cores_path, :method => "post" do
      assert_select "input#cor_descricao", :name => "cor[descricao]"
      assert_select "textarea#cor_observacao", :name => "cor[observacao]"
    end
  end
end
