  class Admin::UsersController < Admin::BaseController
    before_action :set_user, only: %i[ show edit update destroy ]

    def index
      @users = User.all.page(page).per(per)
    end

    def show
    end

    def edit
    end

    def update
    end

    def destroy
      if @user.destroy
        redirect_to admin_users_path, notice: 'User was successfully destroyed.'
      else
        redirect_to admin_users_path, alert: 'User was not destroyed.'
      end
    end

    private
      def user_params
        params.require(:user).permit(:name, :email, :phone_no, :district, :role)
      end

      def set_user
        @user = User.find(params[:id])
      end
  end
