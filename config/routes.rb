Rails.application.routes.draw do
  root 'fuel_card_brands#index'
  resources :fuel_card_brands
  resources :fuel_cards
  resources :fill_ups
  resources :waybills
end
