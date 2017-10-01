Rails.application.routes.draw do

  # admin
  namespace :admin do

      # admin dashboard
      get '', to: 'dashboard#index', as: '/'

      # devise
      devise_for :users, controllers: { sessions: 'admin/users/sessions',
      registrations: 'admin/users/registrations'}

      # admin galleries
      #resources :galleries
      #delete 'galleries/:id', to: 'galleries#destroy', as: 'delete_gallery'

      # admin media
      #resources :media
      #delete 'media/:id', to: 'media#destroy', as: 'delete_media'

      # admin articles
      #resources :articles
      #delete 'articles/:id', to: 'articles#destroy', as: 'delete_articles'
  end

  # user resources
  #resources :galleries, only: [:index, :show]
  #resources :media, only: [:index, :show]
  #resources :articles, only: [:index, :show]

  # user
  root 'pages#welcome'

  # pages
  get 'pages/about'
  
end
