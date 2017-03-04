Rails.application.routes.draw do
  scope ":locale", locale: /#{I18n.available_locales.join("|")}/ do
    root 'fuel_card_brands#index'
    resources :fuel_card_brands
    resources :fuel_cards do
      get :autocomplete_fuel_card_brand_name, on: :collection
    end
    resources :fill_ups
    resources :waybills
  end 
  get '*path', to: redirect("/#{I18n.default_locale}/%{path}")
  get '', to: redirect("/#{I18n.default_locale}")
end
