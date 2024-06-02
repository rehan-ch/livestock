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
    @categories ||= Category.all
  end

  def page
    params[:page].present? ? params[:page] : 1
  end

  def per(per_page = 10)
    params[:per].present? ? params[:per] : per_page
  end
end
