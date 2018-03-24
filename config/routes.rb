Rails.application.routes.draw do
  resources :word_counts
  resources :consumption_preferences
  resources :values
  resources :needs
  resources :personalities
  resources :watson_responses
  resources :text_inputs
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
