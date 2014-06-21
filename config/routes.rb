BlocMail::Application.routes.draw do
  devise_for :users
  resources :lists, only: [:index, :show]
  
  post "lists/:id/subscribe" => 'lists#subscribe'
  post "lists/:id/purge" => 'lists#purge'

  get "reports" => 'reports#index'
  get "reports/index"
  get "reports/:id" => 'reports#view'

  root to: "pages#index"
end
