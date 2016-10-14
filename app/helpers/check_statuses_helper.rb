module CheckStatusesHelper
  def check_status_list
    CheckStatus.order(name: :asc).pluck(:name, :id)
  end
end
