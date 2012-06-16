module SectionsHelper
  def new_child_of(section)
    if section
      unless section.molecule?
        if can? :create, Section
          link_to(new_section_path(parent_id: section.id), class: "btn btn-success") do
            safe_concat(content_tag(:i, nil, class: "icon-plus icon-white") +
            "Add #{section.child_name}")
          end
        end
      end
    else
      if can? :create, Section
        link_to(new_section_path, class: "btn btn-success") do
          safe_concat(content_tag(:i, nil, class: "icon-white icon-plus") +
          " New Chapter")
        end
      end
    end
  end

  def back_to_record_or_toc(section)
    if section.new_record?
      parent = Section.find(params[:parent_id]) if params[:parent_id].present?
      if parent
        path = toc_path(section: parent)
        title = parent.name
        depth_name = parent.child_name
      else
        path = toc_path
        title = "Table of Contents"
        depth_name = "Chapter"
      end
    else
      path = toc_path(section: section)
      title = section.name
      depth_name = section.depth_name
    end
    link_to(path, class: "btn btn-primary", confirm: "This #{depth_name} is not saved, are you sure?") do
      safe_concat(content_tag(:i, nil, class: "icon-white icon-list") + " Back to #{title}")
    end
  end

  def children_list(section)
    list = section ? section.children : Section.roots
    children_title = section.depth == 0 ? "Chemical Families" : "Molecules" if section
    html = []
    html << content_tag(:h3, children_title) if section
    html << render("list", list: list, list_class: "")
    html.join("").html_safe
  end

  def maj(section)
    if section && section.maj.present?
      content_tag :span, class: "timestamps" do
        ["(Last update: ",
          content_tag(:time, l(section.maj.to_date, format: :long), datetime: l(section.maj.to_date, format: :long)),
          ")"
        ].join("").html_safe
      end
    end
  end
  def link_to_edit(section)
    if @section
      if can? :edit, @section
        link_to(edit_section_path(@section), class: "btn btn-inverse") do
            safe_concat(content_tag(:i, nil, class: "icon-pencil icon-white") +
            " Edit this #{@section.depth_name}")
        end
      end
    end
  end

  def page_title(section)
    title = section ? [section.name, section.link_to_pdf].compact.join("").html_safe : "Table of Contents"
    content_tag :h1, title
  end

  def breadcrumb(section)
    if section
      content_tag :ul, class: "breadcrumb" do
        lis = []
        lis << toc_crumb
        section.self_and_ancestors.each do |branch|
          lis << crumb(branch)
        end
        lis.join("").html_safe
      end
    end
  end

  private

  def toc_crumb
    content_tag(:li, link_to("Table of Contents", toc_path) + crumb_divider)
  end

  def crumb_divider(divider=">")
    (" " + content_tag(:span, divider, class: "divider")).html_safe
  end

  def crumb(item)
    not_current = item.id != params[:section].to_i
    item_class = not_current ? nil : "active"
    content_tag(:li, nil, class: item_class) do
      content = link_to_if(not_current, item.name, toc_path(section: item))
      content += crumb_divider if not_current
      content.html_safe
    end.html_safe
  end
end
