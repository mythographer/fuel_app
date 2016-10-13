require 'test_helper'

class FuelCardBrandsControllerTest < ActionDispatch::IntegrationTest
  test 'should get fuel card brand list' do
    #get fuel_card_brands_url
    get '/fuel_card_brands/index'
    assert_response :success
    puts fuel_card_brands_url 
  end

  test 'should get new fuel card brand' do
    get new_fuel_card_brand_url
    assert_response :success
  end

  test 'should create fuel card brand' do
    skip 
  end

  test 'should show fuel card brand' do
    strong = fuel_card_brands :strong
    get fuel_card_brand_url strong
    assert_response :success
  end

  test 'should edit fuel card brand' do
    skip
  end

  test 'should update fuel card brand' do
    skip
  end

  test 'should delete fuel card brand' do
    skip
  end
end
