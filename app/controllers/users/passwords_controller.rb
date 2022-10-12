  class Users::PasswordsController < Devise::PasswordsController
  protected

  def after_resetting_password_path_for(_resource)
    flash[:devise] = true
    password_recovery_successful_path
  end
end
