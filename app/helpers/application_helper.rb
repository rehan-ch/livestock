module ApplicationHelper
  def active_class(variable)
    if controller.controller_name.downcase == variable.downcase
      "active-menu"
    else
      ""
    end
  end
end
