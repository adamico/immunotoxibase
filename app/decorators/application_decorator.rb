class ApplicationDecorator < Draper::Base
  private

  def localize_date(datefield, format=:long)
    I18n.l datefield, format: format
  end

  def handle_none(value, message=" - ", wrap="span")
    if value.present?
      yield
    else
      if wrap
        h.content_tag wrap, message, class: "none"
      else
        message
      end
    end
  end
end
