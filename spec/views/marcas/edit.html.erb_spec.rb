require 'spec_helper'

describe "marcas/edit" do
  before(:each) do
    @marca = assign(:marca, stub_model(Marca,
      :descricao => "MyString",
      :observacao => "MyText"
    ))
  end

  it "renders the edit marca form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => marcas_path(@marca), :method => "post" do
      assert_select "input#marca_descricao", :name => "marca[descricao]"
      assert_select "textarea#marca_observacao", :name => "marca[observacao]"
    end
  end
end
