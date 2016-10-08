Rails.application.routes.draw do
  resources :tasks
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'reminds#new'

  get '/complete_tasks', to: 'tasks#complete'
  get '/reminds/slack', to: 'reminds#slack'
end
