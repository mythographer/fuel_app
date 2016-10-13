require 'test_helper'

class FuelCardBrandsRoutesTest < ActionDispatch::IntegrationTest
  test 'should route to index fuel card brand' do
    assert_routing({ method: :get,  path: 'fuel_card_brands' },
                   { controller: 'fuel_card_brands', action: 'index' })
  end

  test 'should route to new fuel card brand' do
    assert_routing({ method: :get, path: 'fuel_card_brands/new' },
                   { controller: 'fuel_card_brands', action: 'new' })
  end

  test 'should route to create fuel card brand' do
    assert_routing({ method: :post, path: 'fuel_card_brands' },
                   { controller: 'fuel_card_brands', action: 'create' })
  end

  test 'should route to show fuel card brand' do
    assert_routing({ method: :get, path: 'fuel_card_brands/1' },
                   { controller: 'fuel_card_brands', action: 'show', id: '1' })
  end

  test 'should route to edit fuel card brand' do
    assert_routing({ method: :get, path: 'fuel_card_brands/1/edit' },
                   { controller: 'fuel_card_brands', action: 'edit', id: '1' })
  end

  test 'should route to update fuel card brand' do
    assert_routing({ method: :patch, path: 'fuel_card_brands/1' },
                   { controller: 'fuel_card_brands', action: 'update', id: '1' })
  end

  test 'should route to delete fuel card brand' do
    assert_routing({ method: :delete, path: 'fuel_card_brands/1' },
                   { controller: 'fuel_card_brands', action: 'destroy', id: '1' })
  end
end
