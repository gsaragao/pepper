require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe CidadesController do

  # This should return the minimal set of attributes required to create a valid
  # Cidade. As you add validations to Cidade, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    {}
  end
  
  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # CidadesController. Be sure to keep this updated too.
  def valid_session
    {}
  end

  describe "GET index" do
    it "assigns all cidades as @cidades" do
      cidade = Cidade.create! valid_attributes
      get :index, {}, valid_session
      assigns(:cidades).should eq([cidade])
    end
  end

  describe "GET show" do
    it "assigns the requested cidade as @cidade" do
      cidade = Cidade.create! valid_attributes
      get :show, {:id => cidade.to_param}, valid_session
      assigns(:cidade).should eq(cidade)
    end
  end

  describe "GET new" do
    it "assigns a new cidade as @cidade" do
      get :new, {}, valid_session
      assigns(:cidade).should be_a_new(Cidade)
    end
  end

  describe "GET edit" do
    it "assigns the requested cidade as @cidade" do
      cidade = Cidade.create! valid_attributes
      get :edit, {:id => cidade.to_param}, valid_session
      assigns(:cidade).should eq(cidade)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Cidade" do
        expect {
          post :create, {:cidade => valid_attributes}, valid_session
        }.to change(Cidade, :count).by(1)
      end

      it "assigns a newly created cidade as @cidade" do
        post :create, {:cidade => valid_attributes}, valid_session
        assigns(:cidade).should be_a(Cidade)
        assigns(:cidade).should be_persisted
      end

      it "redirects to the created cidade" do
        post :create, {:cidade => valid_attributes}, valid_session
        response.should redirect_to(Cidade.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved cidade as @cidade" do
        # Trigger the behavior that occurs when invalid params are submitted
        Cidade.any_instance.stub(:save).and_return(false)
        post :create, {:cidade => {}}, valid_session
        assigns(:cidade).should be_a_new(Cidade)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Cidade.any_instance.stub(:save).and_return(false)
        post :create, {:cidade => {}}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested cidade" do
        cidade = Cidade.create! valid_attributes
        # Assuming there are no other cidades in the database, this
        # specifies that the Cidade created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Cidade.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, {:id => cidade.to_param, :cidade => {'these' => 'params'}}, valid_session
      end

      it "assigns the requested cidade as @cidade" do
        cidade = Cidade.create! valid_attributes
        put :update, {:id => cidade.to_param, :cidade => valid_attributes}, valid_session
        assigns(:cidade).should eq(cidade)
      end

      it "redirects to the cidade" do
        cidade = Cidade.create! valid_attributes
        put :update, {:id => cidade.to_param, :cidade => valid_attributes}, valid_session
        response.should redirect_to(cidade)
      end
    end

    describe "with invalid params" do
      it "assigns the cidade as @cidade" do
        cidade = Cidade.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Cidade.any_instance.stub(:save).and_return(false)
        put :update, {:id => cidade.to_param, :cidade => {}}, valid_session
        assigns(:cidade).should eq(cidade)
      end

      it "re-renders the 'edit' template" do
        cidade = Cidade.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Cidade.any_instance.stub(:save).and_return(false)
        put :update, {:id => cidade.to_param, :cidade => {}}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested cidade" do
      cidade = Cidade.create! valid_attributes
      expect {
        delete :destroy, {:id => cidade.to_param}, valid_session
      }.to change(Cidade, :count).by(-1)
    end

    it "redirects to the cidades list" do
      cidade = Cidade.create! valid_attributes
      delete :destroy, {:id => cidade.to_param}, valid_session
      response.should redirect_to(cidades_url)
    end
  end

end
