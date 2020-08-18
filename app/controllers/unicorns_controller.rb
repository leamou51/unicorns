class UnicornsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  def index
    @unicorns = Unicorn.all
  end

  def show
    @unicorn = Unicorn.find(params[:id])
  end

  def new
    @unicorn = Unicorn.new
    authorize @unicorn
  end

  def create
    @unicorn = Unicorn.new(params_unicorn)
    @unicorn.user = current_user
    if @unicorn.save
      redirect_to unicorn_show_path(@unicorn)
    else
      render :new
    end
  end

  def params_unicorn
    params.require(:unicorn).permit(:name, :magic_power, :description, :price, :location, photos: [])
  end

  def set_unicorn
    @unicorn = Unicorn.find(params[:id])
  end
end
