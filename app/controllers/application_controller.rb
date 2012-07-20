class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :the_toc_path

  def redirect_with_flash(resource, path=nil, flash_type=:success, message=nil)
    path = resource unless path
    resource = resource[1] if resource.is_a?(Array)
    message = flash_message(resource) unless message
    redirect_to path, flash: {"#{flash_type}" => message}
  end

  private

  def flash_message(instance)
    @flash_message = t("flash.#{self.action_name}", :resource => t('activerecord.models.' + instance.class.name.downcase).classify, :id => instance.to_param)
  end

  def the_toc_path(section)
    toc_path(chapter: get_tree_params(section)[:chapter].to_param, family: get_tree_params(section)[:family].to_param, molecule: get_tree_params(section)[:molecule].to_param)
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

end
