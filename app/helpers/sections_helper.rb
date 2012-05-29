module SectionsHelper
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
