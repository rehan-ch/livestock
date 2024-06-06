class Admin::BaseController < ApplicationController
  before_action  :authenticate_user!, :authenticate_admin!

  layout 'admin'
  # Controller actions
end