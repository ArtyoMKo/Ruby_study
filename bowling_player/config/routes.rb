Rails.application.routes.draw do
  root 'players#index', as: 'home'

  post 'players/simulate' => 'players#simulate'
  post 'players/reset' => 'players#reset'

  resources :players
end
