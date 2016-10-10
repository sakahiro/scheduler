Rails.application.routes.draw do
  resources :tasks do
    collection do
      get 'complete'
      get 'slack'
    end
  end

  root to: 'tasks#index'

  get 'reminds/new', to: 'reminds#new'
  get '/reminds/slack', to: 'reminds#slack'
end
