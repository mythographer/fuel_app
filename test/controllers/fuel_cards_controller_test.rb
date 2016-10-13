require 'test_helper'

class FuelCardsControllerTest < ActionDispatch::IntegrationTest

  teardown do
    Rails.cache.clear
  end

  test "should show list of fuel cards" do
    get fuel_cards_url
    assert_response :success
  end

  test 'should show fuel card' do
    fuel_card = fuel_cards :strong_0123456789
    get fuel_card_url fuel_card
    assert_response :success
  end

  test "should get new" do
    get new_fuel_card_url
    assert_response :success
  end

  test "should get edit" do
    skip
  end

  test "should get create" do
    skip
  end

  test "should update fuel card" do
    fuel_card = fuel_cards :strong_0123456789

    patch fuel_card_url(fuel_card),
      params: { fuel_card: { notes: 'updated' } }

    assert_redirected_to fuel_card_url(fuel_card)
    # Reload association to fetch updated data and assert that notes
    # are updated.
    fuel_card.reload
    assert_equal "updated", fuel_card.notes
  end

  test "should destroy fuel card" do
    skip

    #fuel_card = fuel_cards :strong_0123456789
    #assert_difference('FuelCard.count', -1) do
    #  delete fuel_card_url(fuel_card)
    #end
    #
    #assert_redirected_to fuel_cards_url
  end 
end
