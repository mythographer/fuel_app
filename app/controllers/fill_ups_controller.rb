class FillUpsController < ApplicationController
  before_action :set_fill_up, only: [:show, :edit, :update, :destroy]
  before_action :set_fuel_card_list, only: [:new, :edit, :create]
  before_action :set_product_list, only: [:new, :edit, :create]
  before_action :set_fill_up_status_list, only: [:new, :edit, :create]

  def index
    @fill_ups = FillUp.all_with_joins.page(params[:page])
  end

  def show
    if @fill_up.nil?
      flash[:warning] = 'Fill-up was not found.'
      redirect_to fill_ups_url
    end
  end

  def new
    @fill_up = FillUp.new
  end

  def edit
  end

  def create
    @fill_up = FillUp.new fill_up_params

    if @fill_up.save
      flash[:success] = 'Fill-up was created.'
      redirect_to @fill_up
    else
      render :new
    end
  end

  def update
    if @fill_up.update fill_up_params
      flash[:success] = 'Fill-up was updated.'
      redirect_to @fill_up
    else
      render :edit
    end
  end

  def destroy
    @fill_up.destroy
    flash[:info] = 'Fill-up was deleted.'
    redirect_to fill_ups_url
  end

  private

    def set_fill_up
      @fill_up = FillUp.find_by(id: params[:id])
    end

    def fill_up_params
      params.require(:fill_up).permit(:check_no, :check_datetime,
         :fuel_card_id, :quantity, :unit_price, :comment, :product_id,
         :check_status_id, :filling_station_address, :fuel_supplier_report_id,
         :total_vat)
    end

    def set_fuel_card_list
      @fuel_card_list = helpers.fuel_card_list
    end

    def set_product_list
      @product_list = helpers.product_list
    end

    def set_fill_up_status_list
      @fill_up_status_list = helpers.fill_up_status_list
    end
end
