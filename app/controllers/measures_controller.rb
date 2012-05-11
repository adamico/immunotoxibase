class MeasuresController < ApplicationController
  load_and_authorize_resource
  include TheSortableTreeController::Rebuild

  def tree
    @measures = Measure.nested_set.all
  end

  def new
    if params[:parent_id]
      @parent = Measure.find(params[:parent_id])
      @measure.parent_id = @parent.id
    end
  end

  def create
    if @measure.save
      redirect_to tree_measures_path, notice: "Successfully created #{@measure}"
    else
      render :new
    end
  end

  def edit
    if @measure.parent
      @parent = @measure.parent
    end
  end

  def update
    if @measure.update_attributes(params[:measure])
      redirect_to tree_measures_path, notice: "Successfully updated #{@measure}"
    else
      render :edit
    end
  end

  def destroy
    @measure.destroy
    redirect_to tree_measures_path, notice: "Successfully destroyed #{@measure}"
  end
end
