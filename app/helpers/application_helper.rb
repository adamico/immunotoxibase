module ApplicationHelper
  def link_if_can(text, action, resource, options={})
    text ||= "#{action.to_s.capitalize} #{resource}"
    path = case action
           when :new
             new_polymorphic_path(resource)
           when :edit
             edit_polymorphic_path(resource)
           else
             polymorphic_path(action, resource)
           end
    link_to(text, path, options) if can?(action, resource)
  end
end
