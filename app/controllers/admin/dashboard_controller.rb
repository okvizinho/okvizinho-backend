class Admin::DashboardController < AdminController

  def index
    @admins = Admin
    @users = User
  end

 
end
