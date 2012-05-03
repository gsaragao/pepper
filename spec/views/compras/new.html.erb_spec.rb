require 'spec_helper'

describe "compras/new" do
  before(:each) do
    assign(:compra, stub_model(Compra,
      :descricao => "MyString",
      :observacao => "MyText"
    ).as_new_record)
  end

  it "renders new compra form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => compras_path, :method => "post" do
      assert_select "input#compra_descricao", :name => "compra[descricao]"
      assert_select "textarea#compra_observacao", :name => "compra[observacao]"
    end
  end
end
