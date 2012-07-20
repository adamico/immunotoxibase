class AssessmentDecorator < ApplicationDecorator
  decorates :assessment

  def effet_and_evolution
    if assessment.effet and assessment.evolution
      effet = assessment.effet
      icon_class = case assessment.evolution
                  when -1
                    "icon-arrow-down"
                  when +1
                    "icon-arrow-up"
                  else
                    "icon-resize-horizontal"
                  end
      (effet + " " + h.content_tag(:i, nil, class: icon_class)).html_safe
    end
  end

  # Accessing Helpers
  #   You can access any helper via a proxy
  #
  #   Normal Usage: helpers.number_to_currency(2)
  #   Abbreviated : h.number_to_currency(2)
  #
  #   Or, optionally enable "lazy helpers" by including this module:
  #     include Draper::LazyHelpers
  #   Then use the helpers with no proxy:
  #     number_to_currency(2)

  # Defining an Interface
  #   Control access to the wrapped subject's methods using one of the following:
  #
  #   To allow only the listed methods (whitelist):
  #     allows :method1, :method2
  #
  #   To allow everything except the listed methods (blacklist):
  #     denies :method1, :method2

  # Presentation Methods
  #   Define your own instance methods, even overriding accessors
  #   generated by ActiveRecord:
  #
  #   def created_at
  #     h.content_tag :span, time.strftime("%a %m/%d/%y"),
  #                   :class => 'timestamp'
  #   end
end