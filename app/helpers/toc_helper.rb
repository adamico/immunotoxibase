module TocHelper
  def breadcrumb(item)
    if item.respond_to?(:parent)
      parent = item.parent
      [
        breadcrumb(parent),
        link_to(parent.name, level: parent.class.name.downcase, id: parent.id),
        " > "
      ].join("").html_safe
    end
  end
end
