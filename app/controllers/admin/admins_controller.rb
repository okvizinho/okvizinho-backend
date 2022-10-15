class Admin::AdminsController < AdminController
  before_action :set_admin, only: %i[show edit update destroy]

  def index
    @filters = parse_filters

    admins = Admin.order(id: :desc)

    s = "%#{@filters.q}%"
    is_active = @filters.is_active.to_f
    admins = admins.where('name ilike ? OR email ilike ?', s, s) if @filters.q.present?

    if @filters.is_active.present?
      admins = admins.inactive if is_active.zero?
      admins = admins.active unless is_active.zero?
    end
    @admins = admins.page(current_page)
  end

  def home; end

  def new
    @admin = Admin.new
  end

  def create
    @admin = Admin.new(form_params)

    if @admin.save
      redirect_to admin_admins_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show; end

  def edit; end

  def update
    params = form_params.to_h
    params = params.except!(:password, :password_confirmation) if params[:password].blank?

    if @admin.update(params)
      redirect_to admin_admins_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @admin.destroy
    flash[:success] = 'Admin removido.'
    redirect_to admin_admins_path
  end

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

  def set_admin
    @admin = Admin.find(params[:id])
  end
end
