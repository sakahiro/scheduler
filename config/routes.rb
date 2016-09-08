Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'reminds#new'

  get '/reminds/slack', to: 'reminds#slack'
end
