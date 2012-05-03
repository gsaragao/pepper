require 'spec_helper'

describe "categorias/show" do
  before(:each) do
    @categoria = assign(:categoria, stub_model(Categoria,
      :descricao => "Descricao",
      :id_pai => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Descricao/)
    rendered.should match(/1/)
  end
end
