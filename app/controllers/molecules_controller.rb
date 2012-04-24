class MoleculesController < ApplicationController
  def index
    @molecules = Molecule.text_search(params[:query]).page(params[:page]).per(10)
  end
  def show
    @molecule = Molecule.find(params[:id])
  end
end
