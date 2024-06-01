module ApplicationHelper
  def active_class(variable)
    if controller.controller_name.downcase == variable.downcase
      "active-menu"
    else
      ""
    end
  end

  def first_categories_row
    @first_categories_row ||= categories.first(5)

  end

  def second_categories_row
    @second_categories_row ||= categories.last(5)
  end

  def categories
    @categories ||= Category.all.page(page).per(per)
  end
end
