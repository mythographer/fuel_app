class FuelCardsController < ApplicationController
  before_action :set_fuel_card, only: [:show, :edit, :update, :destroy]
  before_action :set_fuel_card_brand_list, only: [:new, :edit, :create]
  before_action :set_fuel_card_status_list, only: [:new, :edit, :create]

  def index
    @fuel_cards = FuelCard.all_with_joins.paginate(page: params[:page])
  end

  def show
  end

  def new
    @fuel_card = FuelCard.new
  end

  def edit
  end

  def create
    @fuel_card = FuelCard.new fuel_card_params

    if @fuel_card.save
      redirect_to @fuel_card, notice: 'Fuel card was successfully created.'
    else
      render :new
    end
  end

  def update
    if @fuel_card.update fuel_card_params
      redirect_to @fuel_card, notice: 'Fuel card was successfully created.'
    else
      render :edit
    end
  end

  def destroy
    @fuel_card.destroy
    redirect_to fuel_cards_url, notice: 'Fuel card was successfully destroyed.'
  end

  private

    def set_fuel_card
      @fuel_card = FuelCard.find(params[:id])
    end

    def fuel_card_params
      params.require(:fuel_card).permit(:card_no, :fuel_card_brand_id, :notes,
                                        :fuel_card_status_id)
    end

    def set_fuel_card_brand_list
      @fuel_card_brand_list = helpers.fuel_card_brand_list
    end

    def set_fuel_card_status_list
      @fuel_card_status_list = helpers.fuel_card_status_list
    end
end
