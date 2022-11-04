class Admin::DashboardController < AdminController

  def index
    @cities = City
    @users = User
  end

 
end
