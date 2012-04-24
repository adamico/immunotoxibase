class MoleculesController < ApplicationController
  load_and_authorize_resource

  def index
    @molecules = @molecules.text_search(params[:query]).page(params[:page]).per(10)
  end

  def show ; end
  
  def new ; end
end
