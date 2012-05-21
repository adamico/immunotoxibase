class TocController < ApplicationController
  def index
    if params[:level]
      @level = params[:level]
      klass = params[:level].classify.constantize
      @item = klass.find(params[:id])
      if @item.respond_to?(:children)
        @children = @item.children
        @children_title = @children.first.class.name.pluralize
        @children_title = @children_title.prepend("Chemical ") if @children_title == "Families"
      end
    else
      @chapters = Chapter.order(:name)
    end
  end
end
