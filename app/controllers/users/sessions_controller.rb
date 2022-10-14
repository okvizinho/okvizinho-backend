class Users::SessionsController < Devise::SessionsController
  layout 'admin'

  before_action :remove_notice, only: [:new]

  def new
    super
  end

  def remove_notice
    flash[:devise] = true
  end

  def after_sign_in_path_for(resource)
    return admin_dashboard_index_path if resource.is_a?(Admin)

    flash[:devise] = true
    stored_location_for(resource) || super
  end

  def after_sign_out_path_for(resource)
    return admin_session_path if resource.is_a?(Symbol) && resource == :admin
    
    flash[:devise] = true
    site_home_path
  end

  def destroy
    super do
      return redirect_to after_sign_out_path_for(resource_name), status: :see_other
    end
  end
end
