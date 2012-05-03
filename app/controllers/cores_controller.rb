# encoding : utf-8
class CoresController < ApplicationController

  respond_to :html
  before_filter :setar_classe_menu
  before_filter :manage_params, :only => [:index]
  before_filter :load_cor , :only => [:show, :edit, :update, :destroy]

  def index
    @cor = Cor.new(params[:cor])
    @cores = Cor.pesquisar(params[:cor],params[:page])
    respond_with @cores
  end

  def show
    respond_with @cor
  end

  def new
    load_combos
    @cor = Cor.new
    respond_with @cor
  end

  def edit
    load_combos
  end

  def create
    @cor = Cor.new(params[:cor])
    
    if @cor.save
      flash[:notice] = t('msg.create_sucess')
      redirect_to cores_path
    else
      load_combos
      render :action => :new 
    end
     
  end

  def update
    if @cor.update_attributes(params[:cor])
      flash[:notice] = t('msg.update_sucess')
      redirect_to cores_path
    else
      load_combos
      render :action => :edit
    end
  end

  def destroy
    @cor.destroy
    flash[:notice] = t('msg.destroy_sucess')
    redirect_to cores_path
  end
  
  private
  
  def setar_classe_menu
    @class_cor = 'active'  
  end
  
  def load_cor
    begin
      @cor = Cor.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      flash[:alert] = t('msg.data_not_found')
      redirect_to cores_path
    end    
    
  end
  
  def load_combos 
    #Collections
  end
  
  def manage_params
    if (!params[:cor].nil?) 
       params[:cor].delete_if{|k,v| v.blank?}
    end
  end
  
end
