module SectionsHelper
  def new_child_of(section)
    if section
      unless section.molecule?
        if can? :create, Section
          link_to(new_section_path(parent_id: section.to_param), class: "btn btn-success") do
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

  def back_to_record(section)
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
    html << content_tag(:h3, children_title) if section && section.depth != 2
    html << render("list", list: list, list_class: "")
    html.join("").html_safe
  end

  def link_to_item(section, condition=false)
    link_to_unless(condition, "<i class=\"#{icon_css_class(section)}\"></i> #{section.name}".html_safe, toc_path(chapter: get_tree_params(section)[:chapter].to_param, family: get_tree_params(section)[:family].to_param, molecule: get_tree_params(section)[:molecule].to_param))
  end

  def get_tree_params(section)
    level = section.depth
    case level
      when 0
        chapter = section
      when 1
        chapter = section.parent
        family = section
      else
        chapter = section.parent.parent
        family = section.parent
        molecule = section
      end
    return {:chapter => chapter, :family => family, :molecule => molecule}
  end

  def icon_css_class(section)
    level = section.depth
    case level
      when 0
        icon_class = "icon-book"
      when 1
        icon_class = "icon-file"
      else
        icon_class = "icon-tint"
      end
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

  def breadcrumb(section, depth)
    if section
      content_tag :ul, class: "breadcrumb" do
        lis = []
        lis << toc_crumb
        section.self_and_ancestors.each do |branch|
          lis << crumb(branch, depth)
        end
        lis.join("").html_safe
      end
    end
  end

  private

  def toc_crumb
    content_tag(:li, link_to("Table of Contents", toc_path))
  end

  def crumb_divider(divider=">")
    (content_tag(:span, divider, class: "divider")).html_safe
  end

  def crumb(item, depth)
    current = item.depth_name == depth
    item_class = current ? "active" : nil
    contents = []
    contents << crumb_divider
    contents << link_to_item(item, current)
    content_tag :li, contents.join("").html_safe, class: item_class
  end
end
