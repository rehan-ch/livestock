class ServicesController < ApplicationController
  before_action :set_service, only: %i[ show ]

  def index
    @services = Service.published.page.per(per)
  end

  def show;  end

  private
    def set_service
      @service = Service.published.find(params[:id])
    end
end
