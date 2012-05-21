class TocController < ApplicationController
  def index
    if params[:level]
      @level = params[:level]
      klass = params[:level].classify.constantize
      @item = klass.find(params[:id])
    else
      @chapters = Chapter.order(:name)
    end
  end
end
