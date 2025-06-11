module Admin
  class SlidersController < Admin::BaseController
    before_action :set_slider, only: [:edit, :update, :destroy]

    def index
      @sliders = Slider.ordered
    end

    def new
      @slider = Slider.new
    end

    def create
      @slider = Slider.new(slider_params)
      if @slider.save
        redirect_to admin_sliders_path, notice: 'Slider was successfully created.'
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit
    end

    def update
      if @slider.update(slider_params)
        redirect_to admin_sliders_path, notice: 'Slider was successfully updated.'
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @slider.destroy
      redirect_to admin_sliders_path, notice: 'Slider was successfully deleted.'
    end

    private

    def set_slider
      @slider = Slider.find(params[:id])
    end

    def slider_params
      params.require(:slider).permit(:title, :content, :button_text, :button_link, :position, :active, :image)
    end
  end
end
