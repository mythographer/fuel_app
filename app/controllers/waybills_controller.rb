class WaybillsController < ApplicationController
  before_action :set_waybill, only: [:show, :edit, :update, :destroy]

  def index
    @waybills = Waybill.all.chronological.reverse_order.page(params[:page])
  end

  def show
    if @waybill.nil?
      flash[:warning] = 'Waybill was not found.'
      redirect_to waybills_url
    end
  end

  def new
    @waybill = Waybill.new
  end

  def edit
  end

  def create
    @waybill = Waybill.new waybill_params

    if @waybill.save
      flash[:success] = 'Waybill was created.'
      redirect_to @waybill
    else
      render :new
    end
  end

  def update
    if @waybill.update waybill_params
      flash[:success] = 'Waybill was updated.'
      redirect_to @waybill
    else
      render :edit
    end
  end

  def destroy
    @waybill.destroy
    flash[:info] = 'Waybill was deleted.'
    redirect_to waybill_url
  end

  private

    def set_waybill
      @waybill = Waybill.find_by(id: params[:id])
    end

    def waybill_params
      params.require(:waybill).permit(:doc_no, :initial_date, :final_date,
        :vehicle_id, :initial_mileage, :final_mileage, :initial_fuel,
        :final_fuel, :comment)
    end
end
