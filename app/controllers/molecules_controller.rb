class MoleculesController < ApplicationController
  load_and_authorize_resource

  def index
    @molecules = @molecules.text_search(params[:query]).page(params[:page]).per(10)
  end

  def create
    if @molecule.save
      redirect_to @molecule, notice: "Successfully created #{@molecule}"
    else
      render :new
    end
  end

  def update
    if @molecule.update_attributes(params[:molecule])
      redirect_to @molecule, notice: "Successfully updated #{@molecule}"
    else
      render :edit
    end
  end

  def destroy
    @molecule.destroy
    redirect_to molecules_path, notice: "Successfully destroyed #{@molecule}"
  end
end
