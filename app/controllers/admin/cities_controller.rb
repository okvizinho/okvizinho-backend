class Admin::CitiesController < AdminController
  before_action :set_city, only: %i[edit update destroy]

  def index
    @filters = parse_filters

    cities = City.order(id: :desc)

    s = "%#{@filters.q}%"
    is_active = @filters.is_active.to_f
    cities = cities.where('name ilike ?', s) if @filters.q.present?

    if @filters.is_active.present?
      cities = cities.inactive if is_active.zero?
      cities = cities.active unless is_active.zero?
    end
    @cities = cities.page(current_page)
  end

  def new
    @city = City.new
  end

  def create
    @city = City.new(form_params)

    if @city.save
      redirect_to admin_cities_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    params = form_params.to_h

    if @city.update(params)
      redirect_to admin_cities_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @city.destroy
    flash[:success] = 'Cidade removida.'
    redirect_to admin_cities_path
  end

  private

  def parse_filters
    OpenStruct.new(params[:filters])
  end

  def form_params
    params.require(:city).permit(%i[
                                    name
                                    uf
                                    is_active
                                  ])
  end

  def set_city
    @city = City.find(params[:id])
  end
end
