Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :events

  devise_for :members, controllers: {registration: "registration"}

  get 'dashboard/index'
  get 'dashboard/' => 'dashboard#index'


  get 'members' => 'dashboard#index'

  post 'events/:id/' => 'events#attend' , :as => :attend

  #post 'dashboard/index' => 'dashboard#submit', :as => :submit



  get 'home/index'
  root 'home#index'

end
