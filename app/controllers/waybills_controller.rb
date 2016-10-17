class WaybillsController < ApplicationController
  before_action :set_waybill, only: [:show, :edit, :update, :destroy]

  def index
    @waybills = Waybill.all.chronological.reverse_order.page(params[:page])
  end

  def show
  end

  def new
    @waybill = Waybill.new
  end

  def edit
  end

  def create
    @waybill = Waybill.new waybill_params

    if @waybill.save
      redirect_to @waybill, notice: 'Waybill was successfully created.'
    else
      render :new
    end
  end

  def update
    if @waybill.update waybill_params
      redirect_to @waybill, notice: 'Waybill was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @waybill.destroy
    redirect_to waybill_url, notice: 'Waybill was successfully destroyed.'
  end

  private

    def set_waybill
      @waybill = Waybill.find(params[:id])
    end

    def waybill_params
      params.require(:waybill).permit(:doc_no, :initial_date, :final_date,
        :vehicle_id, :initial_mileage, :final_mileage, :initial_fuel,
        :final_fuel, :comment)
    end
end
