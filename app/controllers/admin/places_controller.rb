class Admin::PlacesController < AdminController
  before_action :set_place, only: %i[edit update destroy]
  before_action :set_cities

  def index
    @filters = parse_filters

    places = Place.order(id: :desc)

    s = "%#{@filters.q}%"
    is_active = @filters.is_active.to_f
    places = places.where('title ilike ?', s) if @filters.q.present?

    if @filters.is_active.present?     
      places = places.inactive if is_active.zero?
      places = places.active unless is_active.zero?
    end
    @places = places.page(current_page)
  end

  def new
    @place = Place.new
  end

  def create
    @place = Place.new(form_params)

    if @place.save
      redirect_to admin_places_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    params = form_params.to_h
    
    if @place.update(params)
      redirect_to admin_places_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @place.destroy
    flash[:success] = 'Lugar removido.'
    redirect_to admin_places_path
  end

  private

  def parse_filters
    OpenStruct.new(params[:filters])
  end

  def form_params
    params.require(:place).permit(%i[
                                    city_id
                                    title 
                                    description
                                    cover_image
                                    district
                                    is_active
                                  ])
  end

  def set_place
    @place = Place.find(params[:id])
  end

  def set_cities 
    @cities = City.active
  end
end
