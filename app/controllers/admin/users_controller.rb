class Admin::UsersController < AdminController
  before_action :set_user, only: %i[show]

  def index
    @filters = parse_filters

    users = User.order(id: :desc)

    s = "%#{@filters.q}%"
    is_active = @filters.is_active.to_f
    users = users.where('name ilike ? OR email ilike ?', s, s) if @filters.q.present?

    if @filters.is_active.present?
      users = users.inactive if is_active.zero?
      users = users.active unless is_active.zero?
    end
    @users = users.page(current_page)
  end

  def show; end

  private

  def parse_filters
    OpenStruct.new(params[:filters])
  end

  def form_params
    params.require(:admin).permit(%i[
                                    name
                                    email
                                    password
                                    password_confirmation
                                    is_active
                                  ])
  end

  def set_user
    @user = User.find(params[:id])
  end
end
