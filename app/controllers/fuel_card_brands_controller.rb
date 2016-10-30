class FuelCardBrandsController < ApplicationController
  before_action :set_fuel_card_brand, only: %i(show edit update destroy)

  def index
    @fuel_card_brands = FuelCardBrand.all.page(params[:page])
  end

  def show
    if @fuel_card_brand.nil?
      flash[:warning] = 'Fuel card brand was not found.'
      redirect_to fuel_card_brands_url
    end
  end

  def new
    @fuel_card_brand = FuelCardBrand.new
  end

  def edit
  end

  def create
    @fuel_card_brand = FuelCardBrand.new fuel_card_brand_params

    if @fuel_card_brand.save
      flash[:success] = 'Fuel card brand was created.'
      redirect_to @fuel_card_brand
    else
      render :new
    end
  end

  def update
    if @fuel_card_brand.update fuel_card_brand_params
      flash[:success] = 'Fuel card brand was updated.'
      redirect_to @fuel_card_brand
    else
      render :edit
    end
  end

  def destroy
    @fuel_card_brand.destroy
    flash[:info] = 'Fuel card brand was deleted.'
    redirect_to fuel_card_brands_url
  end

  private

    def set_fuel_card_brand
      @fuel_card_brand = FuelCardBrand.find_by(id: params[:id])
    end

    def fuel_card_brand_params
      params.require(:fuel_card_brand).permit(:name)
    end
end
