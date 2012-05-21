module ApplicationHelper
  def children_for(instance)
    if instance.has_children?
      children = instance.children
      children_title = instance.child_class_name.capitalize.pluralize
      children_title = children_title.prepend("Chemical ") if children_title == "Families"
      content_tag(:h3, children_title) +
      render("list", list: instance.children, list_class: "")
    end
  end
  def new_child_of(instance)
    if instance.respond_to?(:children) && instance.children
      child = instance.child_class_name.classify.constantize
      class_name = instance.class.name.downcase
      if can? :new, child
        link_to new_polymorphic_path(child, "#{class_name}_id" => instance.id), class: "btn btn-success" do
          safe_concat(content_tag(:i, nil, class: "icon-plus icon-white") +
          "Add #{@item.child_class_name}")
        end
      end
    end
  end

  def assessments_for(instance)
    if params[:level] == "molecule" && instance.respond_to?(:assessments) && instance.assessments.any?
      render "assessments", assessments: instance.assessments
    end
  end
  def picture_for(instance)
    if params[:level] == "molecule"
      image_tag instance.picture.url if instance.respond_to?(:picture) && instance.picture.present?
    end
  end
  def link_to_pdf(instance)
    if params[:level] == "molecule"
      content_tag :small do
        link_to "#" do
          image_tag("pdficon_large.gif", alt: "PDF Version", title: "PDF Version")
        end
      end
    end
  end

  def maj(instance)
    if instance.respond_to?(:maj)
      content_tag :p, class: "timestamps" do
        safe_concat("(Last update: " +
          content_tag(:time, l(@item.updated_at.to_date, format: :long), datetime: l(@item.updated_at.to_date)) + ")"
        )
      end
    end
  end

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
