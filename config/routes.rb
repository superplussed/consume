Consume::Application.routes.draw do

  # require 'sidekiq/web'
  # mount Sidekiq::Web => '/admin/sidekiq'

  # authenticate :user, lambda { |u| u.has_role?(:super_admin) } do
  #   mount Sidekiq::Web => '/admin/sidekiq'
  # end

  root 'job_listings#index'
  
  resources :job_listings do
    get :scrape
  end

  resources :cities

end
