class HomeController < ApplicationController
  def index
  end

  def admin
  end

  def autocomplete_section_name
    term = params[:term]
    if term && term.present?
      items = Section.where(depth: 2).where("LOWER(name) like ?", term.downcase + "%").limit(10).order(:name)
    else
      items = {}
    end
    render json: json_for_autocomplete(items, "name".downcase)
  end
end
