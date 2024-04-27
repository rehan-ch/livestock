module Admin::DashboardHelper
    def active_tab(curr_tab)
        params[:controller].split('/')[1] == curr_tab
    end
end
