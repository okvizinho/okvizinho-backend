class Admin::SpacesController < AdminController
  before_action :set_space, only: %i[edit update destroy]
  before_action :set_cities

  def index
    @filters = parse_filters

    spaces = Space.order(id: :desc)

    s = "%#{@filters.q}%"
    is_active = @filters.is_active.to_f
    spaces = spaces.where('title ilike ?', s) if @filters.q.present?

    if @filters.is_active.present?     
      spaces = spaces.inactive if is_active.zero?
      spaces = spaces.active unless is_active.zero?
    end
    @spaces = spaces.page(current_page)
  end

  def new
    @space = Space.new
  end

  def create
    @space = Space.new(form_params)

    if @space.save
      redirect_to admin_spaces_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    params = form_params.to_h
    
    if @space.update(params)
      redirect_to admin_spaces_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @space.destroy
    flash[:success] = 'Espaço removido.'
    redirect_to admin_spaces_path
  end

  private

  def parse_filters
    OpenStruct.new(params[:filters])
  end

  def form_params
    params.require(:space).permit(%i[
                                    city_id
                                    kind
                                    title 
                                    description
                                    cover_image
                                    district
                                    is_active
                                  ])
  end

  def set_space
    @space = Space.find(params[:id])
  end

  def set_cities 
    @cities = City.active
  end
end
