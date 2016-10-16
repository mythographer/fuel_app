class ChecksController < ApplicationController
  before_action :set_check, only: [:show, :edit, :update, :destroy]
  before_action :set_fuel_card_list, only: [:new, :edit, :create]
  before_action :set_product_list, only: [:new, :edit, :create]
  before_action :set_check_status_list, only: [:new, :edit, :create]

  def index
    @checks = Check.all_with_joins.paginate(page: params[:page])
  end

  def show
  end

  def new
    @check = Check.new
  end

  def edit
  end

  def create
    @check = Check.new check_params

    if @check.save
      redirect_to @check, notice: 'Check was successfully created.'
    else
      render :new
    end
  end

  def update
    if @check.update check_params
      redirect_to @check, notice: 'Check was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @check.destroy
    redirect_to checks_url, notice: 'Check was successfully destroyed.'
  end

  private

    def set_check
      @check = Check.find(params[:id])
    end

    def check_params
      params.require(:check).permit(:check_no, :check_datetime,
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

    def set_check_status_list
      @check_status_list = helpers.check_status_list
    end
end
