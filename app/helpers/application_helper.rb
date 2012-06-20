module ApplicationHelper
  def link_if_can(text, action, resource, icon="", options={})
    text ||= "#{action.to_s.capitalize} #{resource}"
    case action
    when :new
      path = new_polymorphic_path(resource)
      icon = "plus"
      css = "success"
    when :edit
      path = edit_polymorphic_path(resource)
      icon = "pencil"
      css = "warning"
    when :destroy
      path = polymorphic_path(resource)
      icon = "trash"
      css = "danger"
      options = {confirm: "Are you sure?", method: :delete}
    end
    options = options.merge(class: "btn btn-#{css}")
    if can?(action, resource)
      link_to(path, options) do
        content_tag(:i, "", class: "icon-#{icon} icon-white") + " #{text}"
      end
    end
  end
end
