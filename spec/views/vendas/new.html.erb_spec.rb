require 'spec_helper'

describe "vendas/new" do
  before(:each) do
    assign(:venda, stub_model(Venda,
      :cliente => nil,
      :vendedor => nil,
      :observacao => "MyText"
    ).as_new_record)
  end

  it "renders new venda form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => vendas_path, :method => "post" do
      assert_select "input#venda_cliente", :name => "venda[cliente]"
      assert_select "input#venda_vendedor", :name => "venda[vendedor]"
      assert_select "textarea#venda_observacao", :name => "venda[observacao]"
    end
  end
end
