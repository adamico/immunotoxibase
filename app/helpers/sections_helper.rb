module SectionsHelper
  def old_breadcrumb(item)
    if item
      parent = item.parent
      if parent
        name = parent.name
        path = parent
      else
        name = "Table of Contents"
        path = toc_path
      end
      parent = item.parent
      [
        breadcrumb(parent),
        link_to(name, path),
        " > ",
        item.name
      ].join("").html_safe
    else
      ""
    end
  end

  def breadcrumb(item)
    content_tag :ul, class: "breadcrumb" do
      lis = []
      lis << toc_crumb
      item.self_and_ancestors.each do |branch|
        lis << crumb(branch)
      end
      lis.join("").html_safe
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
    not_current = item.id != params[:id].to_i
    item_class = not_current ? nil : "active"
    content_tag(:li, nil, class: item_class) do
      content = link_to_if(not_current, item.name, item)
      content += crumb_divider if not_current
      content.html_safe
    end.html_safe
  end
end
