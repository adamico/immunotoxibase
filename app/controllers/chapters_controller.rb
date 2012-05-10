class ChaptersController < ApplicationController
  load_and_authorize_resource

  def create
    if @chapter.save
      redirect_to toc_path(level: "chapter", id: @chapter.id), notice: "Successfully created #{@chapter}"
    else
      render :new
    end
  end

  def update
    if @chapter.update_attributes(params[:chapter])
      redirect_to toc_path(level: "chapter", id: @chapter.id), notice: "Successfully updated #{@chapter}"
    else
      render :edit
    end
  end

  def destroy
    @chapter.destroy
    redirect_to toc_path, notice: "Successfully destroyed #{@chapter}"
  end
end
