Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :word_counts
      resources :consumption_preferences
      resources :values
      resources :needs
      resources :personalities
      resources :twitter_accounts
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
