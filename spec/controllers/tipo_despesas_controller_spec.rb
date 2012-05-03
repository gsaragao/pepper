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

describe TipoDespesasController do

  # This should return the minimal set of attributes required to create a valid
  # TipoDespesa. As you add validations to TipoDespesa, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    {}
  end
  
  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # TipoDespesasController. Be sure to keep this updated too.
  def valid_session
    {}
  end

  describe "GET index" do
    it "assigns all tipo_despesas as @tipo_despesas" do
      tipo_despesa = TipoDespesa.create! valid_attributes
      get :index, {}, valid_session
      assigns(:tipo_despesas).should eq([tipo_despesa])
    end
  end

  describe "GET show" do
    it "assigns the requested tipo_despesa as @tipo_despesa" do
      tipo_despesa = TipoDespesa.create! valid_attributes
      get :show, {:id => tipo_despesa.to_param}, valid_session
      assigns(:tipo_despesa).should eq(tipo_despesa)
    end
  end

  describe "GET new" do
    it "assigns a new tipo_despesa as @tipo_despesa" do
      get :new, {}, valid_session
      assigns(:tipo_despesa).should be_a_new(TipoDespesa)
    end
  end

  describe "GET edit" do
    it "assigns the requested tipo_despesa as @tipo_despesa" do
      tipo_despesa = TipoDespesa.create! valid_attributes
      get :edit, {:id => tipo_despesa.to_param}, valid_session
      assigns(:tipo_despesa).should eq(tipo_despesa)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new TipoDespesa" do
        expect {
          post :create, {:tipo_despesa => valid_attributes}, valid_session
        }.to change(TipoDespesa, :count).by(1)
      end

      it "assigns a newly created tipo_despesa as @tipo_despesa" do
        post :create, {:tipo_despesa => valid_attributes}, valid_session
        assigns(:tipo_despesa).should be_a(TipoDespesa)
        assigns(:tipo_despesa).should be_persisted
      end

      it "redirects to the created tipo_despesa" do
        post :create, {:tipo_despesa => valid_attributes}, valid_session
        response.should redirect_to(TipoDespesa.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved tipo_despesa as @tipo_despesa" do
        # Trigger the behavior that occurs when invalid params are submitted
        TipoDespesa.any_instance.stub(:save).and_return(false)
        post :create, {:tipo_despesa => {}}, valid_session
        assigns(:tipo_despesa).should be_a_new(TipoDespesa)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        TipoDespesa.any_instance.stub(:save).and_return(false)
        post :create, {:tipo_despesa => {}}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested tipo_despesa" do
        tipo_despesa = TipoDespesa.create! valid_attributes
        # Assuming there are no other tipo_despesas in the database, this
        # specifies that the TipoDespesa created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        TipoDespesa.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, {:id => tipo_despesa.to_param, :tipo_despesa => {'these' => 'params'}}, valid_session
      end

      it "assigns the requested tipo_despesa as @tipo_despesa" do
        tipo_despesa = TipoDespesa.create! valid_attributes
        put :update, {:id => tipo_despesa.to_param, :tipo_despesa => valid_attributes}, valid_session
        assigns(:tipo_despesa).should eq(tipo_despesa)
      end

      it "redirects to the tipo_despesa" do
        tipo_despesa = TipoDespesa.create! valid_attributes
        put :update, {:id => tipo_despesa.to_param, :tipo_despesa => valid_attributes}, valid_session
        response.should redirect_to(tipo_despesa)
      end
    end

    describe "with invalid params" do
      it "assigns the tipo_despesa as @tipo_despesa" do
        tipo_despesa = TipoDespesa.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        TipoDespesa.any_instance.stub(:save).and_return(false)
        put :update, {:id => tipo_despesa.to_param, :tipo_despesa => {}}, valid_session
        assigns(:tipo_despesa).should eq(tipo_despesa)
      end

      it "re-renders the 'edit' template" do
        tipo_despesa = TipoDespesa.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        TipoDespesa.any_instance.stub(:save).and_return(false)
        put :update, {:id => tipo_despesa.to_param, :tipo_despesa => {}}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested tipo_despesa" do
      tipo_despesa = TipoDespesa.create! valid_attributes
      expect {
        delete :destroy, {:id => tipo_despesa.to_param}, valid_session
      }.to change(TipoDespesa, :count).by(-1)
    end

    it "redirects to the tipo_despesas list" do
      tipo_despesa = TipoDespesa.create! valid_attributes
      delete :destroy, {:id => tipo_despesa.to_param}, valid_session
      response.should redirect_to(tipo_despesas_url)
    end
  end

end
