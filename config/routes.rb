Rails.application.routes.draw do
  root 'fuel_card_brands#index'
  resources :fuel_card_brands
  resources :fuel_cards do
    get :autocomplete_fuel_card_brand_name, on: :collection
  end
  resources :fill_ups
  resources :waybills
end
