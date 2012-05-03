require 'spec_helper'

describe "categorias/new" do
  before(:each) do
    assign(:categoria, stub_model(Categoria,
      :descricao => "MyString",
      :id_pai => 1
    ).as_new_record)
  end

  it "renders new categoria form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => categorias_path, :method => "post" do
      assert_select "input#categoria_descricao", :name => "categoria[descricao]"
      assert_select "input#categoria_id_pai", :name => "categoria[id_pai]"
    end
  end
end
