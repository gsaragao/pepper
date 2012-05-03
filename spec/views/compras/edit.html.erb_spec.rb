require 'spec_helper'

describe "compras/edit" do
  before(:each) do
    @compra = assign(:compra, stub_model(Compra,
      :descricao => "MyString",
      :observacao => "MyText"
    ))
  end

  it "renders the edit compra form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => compras_path(@compra), :method => "post" do
      assert_select "input#compra_descricao", :name => "compra[descricao]"
      assert_select "textarea#compra_observacao", :name => "compra[observacao]"
    end
  end
end
