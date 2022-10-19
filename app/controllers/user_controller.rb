class UserController < ApplicationController
  before_action :doorkeeper_authorize!
  before_action :authenticate_user!

  def current_user
    super || User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
  end

  private

  def authenticate_user!
    head(:forbidden) and return unless current_user
  end

  helper_method :current_user
end
