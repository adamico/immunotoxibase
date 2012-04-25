module ApplicationHelper
  def link_to_add_fields(name, f, association)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s.singularize + "_fields", f: builder)
    end
    link_to '#', class: "btn btn-primary add_fields", data: {id: id, fields: fields.gsub("\n", "")} do
      content_tag(:i, "", class: "icon-white icon-plus") + " #{name}"
    end
  end
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
