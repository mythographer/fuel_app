class FuelCardsController < ApplicationController
  before_action :set_fuel_card, only: [:show, :edit, :update, :destroy]
  before_action :set_fuel_card_brand_list, only: [:new, :edit, :create]
  before_action :set_fuel_card_status_list, only: [:new, :edit, :create]
  autocomplete :fuel_card_brand, :name, full: true

  def index
    @fuel_cards = FuelCard.all_with_joins.page(params[:page])
  end

  def show
    if @fuel_card.nil?
      flash[:warning] = 'Fuel card was not found.'
      redirect_to fuel_cards_url
    end
  end

  def new
    @fuel_card = FuelCard.new
  end

  def edit
  end

  def create
    @fuel_card = FuelCard.new fuel_card_params

    if @fuel_card.save
      flash[:success] = 'Fuel card was created.'
      redirect_to @fuel_card
    else
      render :new
    end
  end

  def update
    if @fuel_card.update fuel_card_params
      flash[:success] = 'Fuel card was updated.'
      redirect_to @fuel_card
    else
      render :edit
    end
  end

  def destroy
    @fuel_card.destroy
    flash[:info] = 'Fuel card was deleted.'
    redirect_to fuel_cards_url
  end

  private

    def set_fuel_card
      @fuel_card = FuelCard.find_by(id: params[:id])
    end

    def fuel_card_params
      params.require(:fuel_card).permit(:card_no, :fuel_card_brand_name,
                                        :notes, :fuel_card_status_id)
    end

    def set_fuel_card_brand_list
      @fuel_card_brand_list = helpers.fuel_card_brand_list
    end

    def set_fuel_card_status_list
      @fuel_card_status_list = helpers.fuel_card_status_list
    end
end
