Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'myrdinkeys#new_install'
  resources :characters, controller: 'characters'
  post 'characters/batch' => 'characters#batch'
  resources :apikeys, controller: 'myrdinkeys'
end
