class Admin::AdminsController < AdminController
  before_action :set_admin, only: [:show, :edit, :update, :destroy]

  def index
    admins = Admin.order(id: :desc)

    if params[:q].present?
      s = "%#{params[:q]}%"
      admins = admins.where("name ilike ? OR email ilike ?", s, s)
    end

    @admins = admins.page(current_page)
  end

  def home
  end


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

  def show
  end

  def edit
  end

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
    flash[:success] = "Admin removido."
    redirect_to admin_admins_path
  end

  private

  def form_params
    params.require(:admin).permit([
        :name,
        :email,
        :password,
        :password_confirmation
    ])
  end

  def set_admin
    @admin = Admin.find(params[:id])
  end
end
