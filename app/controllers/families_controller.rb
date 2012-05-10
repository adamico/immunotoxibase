class FamiliesController < ApplicationController
  load_and_authorize_resource

  def new
    @family.chapter_id = params[:chapter_id]
  end

  def create
    if @family.save
      redirect_to toc_path(level: "family", id: @family.id), notice: "Successfully created #{@family}"
    else
      render :new
    end
  end

  def update
    if @family.update_attributes(params[:family])
      redirect_to toc_path(level: "family", id: @family.id), notice: "Successfully updated #{@family}"
    else
      render :edit
    end
  end

  def destroy
    @family.destroy
    redirect_to toc_path, notice: "Successfully destroyed #{@family}"
  end
end
