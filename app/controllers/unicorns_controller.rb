class UnicornsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :set_unicorn, only: [:edit, :update,:destroy]
  def index
    search = params[:search]
    if !search.nil?
      @unicorns = Unicorn.near(search[:query], 10)
      @booking_start = search[:startdate]
      @booking_end = search[:enddate]
    else
      @unicorns = Unicorn.all
    end

    @markers = @unicorns.map do |unicorn|
      {
        lat: unicorn.latitude,
        lng: unicorn.longitude,
        infoWindow: render_to_string(partial: "info_window", locals: { unicorn: unicorn }),
        image_url: helpers.asset_url('mascotte.png'),
        id: unicorn.id
      }
    end
  end

  def show
    @unicorn = Unicorn.find(params[:id])
    @booking = Booking.new
    @booking_start = params[:start]
    @booking_end = params[:end]
  end

  def new
    @unicorn = Unicorn.new
    authorize @unicorn
  end

  def create
    @unicorn = Unicorn.new(params_unicorn)
    @unicorn.user = current_user
    if @unicorn.save
      redirect_to unicorn_path(@unicorn)
    else
      render :new
    end
  end

  def edit
  end

  def update
    @unicorn.update(params_unicorn)
    @unicorn.user = current_user
    if @unicorn.save
      redirect_to unicorn_path(@unicorn)
    else
      render :new
    end
  end

  def destroy
    @unicorn.destroy
    redirect_to dashboard_path
  end

  private

  def params_unicorn
    params.require(:unicorn).permit(:name, :magic_power, :description, :price, :location, photos: [])
  end

  def set_unicorn
    @unicorn = Unicorn.find(params[:id])
  end
end
