class SectionsController < ApplicationController
  load_and_authorize_resource

  def toc
    section = Section.find(params[:section]) if params[:section]
    @section = SectionDecorator.find(section) if section
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

  def update
    if @section.update_attributes
      redirect_to @section, notice: "Successfully updated #{@section}"
    else
      render :edit
    end
  end

  def destroy
  end
end
