require 'spec_helper'

describe "tamanhos/new" do
  before(:each) do
    assign(:tamanho, stub_model(Tamanho,
      :descricao => "MyString",
      :observacao => "MyText"
    ).as_new_record)
  end

  it "renders new tamanho form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => tamanhos_path, :method => "post" do
      assert_select "input#tamanho_descricao", :name => "tamanho[descricao]"
      assert_select "textarea#tamanho_observacao", :name => "tamanho[observacao]"
    end
  end
end
