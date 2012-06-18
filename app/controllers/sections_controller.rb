class SectionsController < ApplicationController
  load_and_authorize_resource

  helper_method :current_section_depth

  def autocomplete_reference_description
    term = params[:term]
    if term && term.present?
      items = Reference.where("LOWER(description) like ?", term.downcase + "%").limit(20).order(:description)
    else
      items = {}
    end
    render json: json_for_autocomplete(items, :description)
  end

  def toc
    section = Section.find(params[current_section_depth]) if current_section_depth
    @depth = current_section_depth
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

  private

  def current_section_depth
    if params[:molecule].nil?
      if params[:family].nil?
        if params[:chapter].nil?
          depth = nil
        else
          depth = "chapter"
        end
      else
        depth = "family"
      end
    else
      depth = "molecule"
    end
    @depth ||= depth
  end
end
