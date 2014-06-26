BlocMail::Application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }

  resources :lists, only: [:index, :show]
  resources :campaigns, only: [:index, :show]

  resources :purges
  
  post "lists/:id/subscribe" => 'lists#subscribe'
  post "lists/:id/purge" => 'lists#purge'

  get "reports" => 'reports#index'
  get "reports/index"
  get "reports/:id" => 'reports#view'

  root to: "pages#index"
end
