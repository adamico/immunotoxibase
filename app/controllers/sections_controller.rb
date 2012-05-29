class SectionsController < ApplicationController
  load_and_authorize_resource

  def toc
    @sections = Section.roots
  end

  def show
  end

  def new
    if params[:parent_id]
      @parent = Section.find(params[:parent_id])
      @section.parent_id = @parent.id
    end
  end

  def create
    if @section.save
      redirect_to @section, notice: "Successfully created #{@section}"
    else
      render :new
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
