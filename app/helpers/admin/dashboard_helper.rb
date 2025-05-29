module Admin::DashboardHelper
  def active_tab(curr_tab)
    "active" if controller.controller_name.downcase == curr_tab.downcase
  end

  def active_tab_with_tabs(curr_tab, tabs)
    "active"  if (controller.controller_name.downcase == curr_tab.downcase) && (params[:type]&.downcase == tabs.downcase)    
  end

  def dynamic_breadcrum_path
    send("admin_#{controller_name}_path") rescue nil
  end
end
