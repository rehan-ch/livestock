module Admin::DashboardHelper
    def active_tab(curr_tab)
        "active" if controller.controller_name.downcase == curr_tab.downcase
    end
    def active_tab_with_tabs(curr_tab, tabs)
        if (controller.controller_name.downcase == curr_tab.downcase) && (params[:type]&.downcase == tabs.downcase)
            "active"
        end
    end
end
