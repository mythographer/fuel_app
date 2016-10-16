require 'test_helper'

class WaybillsControllerTest < ActionDispatch::IntegrationTest
  test "should get waybill list" do
    get waybills_url
    assert_response :success
  end

  test "should show waybill" do
    waybill = waybills :september_2016_one
    get waybills_url waybill
    assert_response :success
  end

end
