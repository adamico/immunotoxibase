class ReferencesController < ApplicationController
  load_and_authorize_resource

  helper_method :form_title

  def new
    respond_to do |format|
      format.html
      format.js { render :new, layout: false}
    end
  end

  def create
    if @reference.save
      respond_to do |format|
        format.html { redirect_with_flash @reference, nil, :success, "Reference #{@reference.oldid_or_id} successfully created." }
        format.js { render json: {:id => @reference.id, :label => @reference.description }}
      end
    else
      respond_to do |format|
        format.html { render :new, status: :not_acceptable }
        format.js { render :new, layout: false, status: :not_acceptable }
      end
    end
  end

  def update
    if @reference.update_attributes(params[:reference])
      respond_to do |format|
        format.html { redirect_with_flash @reference, nil, :success, "Reference #{@reference.oldid_or_id} successfully updated." }
        format.js { render json: {:id => @reference.id, :label => @reference.description }}
      end
    else
      respond_to do |format|
        format.html { render :edit, status: :not_acceptable }
        format.js { render :edit, layout: false, status: :not_acceptable }
      end
    end
  end

  def edit
    respond_to do |format|
      format.html
      format.js { render :edit, layout: false}
    end
  end

  private

  def form_title
    @form_title ||= params[:id] && params[:id].present? ? "Edit reference: #{@reference.oldid_or_id}" : "New reference"
  end
end
