Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :word_counts, only: [:index]
      resources :consumption_preferences, only: [:index]
      resources :values, only: [:index]
      resources :needs, only: [:index]
      resources :personalities, only: [:index, :personality]
      resources :twitter_accounts do
        get '/word_count', to: 'word_counts#word_count'
        get '/consumption_preference', to: 'consumption_preferences#consumption_preference'
        get '/value', to: 'values#value'
        get '/need', to: 'needs#need'
        get '/personality', to: 'personalities#personality'
      end
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
