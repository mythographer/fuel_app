class FuelCardBrandsController < ApplicationController
  before_action :set_fuel_card_brand, only: [:show, :edit, :update, :destroy]

  def index
    @fuel_card_brands = FuelCardBrand.all.page(params[:page])
  end

  def show
  end

  def new
    @fuel_card_brand = FuelCardBrand.new
  end

  def edit
  end

  def create
    @fuel_card_brand = FuelCardBrand.new fuel_card_brand_params

    if @fuel_card_brand.save
      redirect_to @fuel_card_brand, notice: 'Fuel card brand was successfully created.' 
    else
      render :new
    end
  end

  def update
    if @fuel_card_brand.update fuel_card_brand_params
      redirect_to @fuel_card_brand, notice: 'Fuel card brand was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @fuel_card_brand.destroy
    redirect_to fuel_card_brands_url, notice: 'Fuel card brand was successfully destroyed.'
  end

  private

    def set_fuel_card_brand
      @fuel_card_brand = FuelCardBrand.find(params[:id])
    end

    def fuel_card_brand_params
      params.require(:fuel_card_brand).permit(:brand_name)
    end
end
