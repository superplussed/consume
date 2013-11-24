Consume::Application.routes.draw do
  require 'sidekiq/web'

  authenticate :user, lambda { |u| u.admin? } do
    mount Sidekiq::Web => '/admin/sidekiq'
  end
  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'
  
  devise_for :users

  root 'job_listings#index'
  
  resources :job_listings do
    get :scrape
  end

  resources :cities

end
