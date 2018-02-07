Rails.application.routes.draw do
  
  resources :projects do
  	resources :bugs, except: :destroy
  end

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root to: 'projects#index'
end
