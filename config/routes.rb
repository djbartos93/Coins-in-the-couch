Rails.application.routes.draw do
  resources :movies

  root to: "movies#index"
  post 'sync' => 'movies#sync'
  get 'search/index'
  post 'search/query'
end
