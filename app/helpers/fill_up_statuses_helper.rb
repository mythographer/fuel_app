module FillUpStatusesHelper
  def fill_up_status_list
    FillUpStatus.order(name: :asc).pluck(:name, :id)
  end
end
