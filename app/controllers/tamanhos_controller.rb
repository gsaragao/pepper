# encoding : utf-8
class TamanhosController < ApplicationController

  respond_to :html
  before_filter :setar_classe_menu
  before_filter :manage_params, :only => [:index]
  before_filter :load_tamanho , :only => [:show, :edit, :update, :destroy]

  def index
    @tamanho = Tamanho.new(params[:tamanho])
    @tamanhos = Tamanho.pesquisar(params[:tamanho],params[:page])
    respond_with @tamanhos
  end

  def show
    respond_with @tamanho
  end

  def new
    load_combos
    @tamanho = Tamanho.new
    respond_with @tamanho
  end

  def edit
    load_combos
  end

  def create
    @tamanho = Tamanho.new(params[:tamanho])
    Tamanho.transaction do
      valida_check_create(@tamanho.default)
      if @tamanho.save
        flash[:notice] = t('msg.create_sucess')
        redirect_to tamanhos_path
      else
        load_combos
        render :action => :new 
      end
    end 
  end

  def update
    Tamanho.transaction do
      valida_check_update(@tamanho)
      if @tamanho.update_attributes(params[:tamanho])
        flash[:notice] = t('msg.update_sucess')
        redirect_to tamanhos_path
      else
        load_combos
        render :action => :edit
      end
   end
  end

  def destroy
    if @tamanho.destroy
      flash[:notice] = t('msg.destroy_sucess')
    else
      flash[:alert] = @tamanho.errors.full_messages[0]
    end    
    redirect_to tamanhos_path
  end
  
  private
  
  def setar_classe_menu
    @class_tamanho = 'active'  
  end
  
  def load_tamanho
    begin
      @tamanho = Tamanho.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      flash[:alert] = t('msg.data_not_found')
      redirect_to tamanhos_path
    end    
  end  
  
  def load_combos 
    #Collections
  end
  
  def manage_params
    if (!params[:tamanho].nil?) 
       params[:tamanho].delete_if{|k,v| v.blank?}
    end
  end
  
  def valida_check_create(value)
      if (value == 1 || value == '1')  
        Tamanho.update_all(:default => nil)
      end 
  end
  
  def valida_check_update(tamanho)
    if (tamanho.default == 0 || tamanho.default == nil) 
        Tamanho.update_all(:default => nil)
    end 
  end
  
  
end
