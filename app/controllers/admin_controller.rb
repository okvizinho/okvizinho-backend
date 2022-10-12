class AdminController < ApplicationController
  #before_action :authenticate_admin!
  layout 'admin'

  # def current_page
  #   params[:page] || 1
  # end

  # private

  # def authenticate_admin!
  #   redirect_to(new_admin_session_path) unless current_admin
  # end
end
