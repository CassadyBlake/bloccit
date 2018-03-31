Rails.application.routes.draw do

  resources :topics do
    resources :posts, except: [:index]
    resources :sponsored_posts, except: [:index]
  end

  resources :users, only: [:new, :create]
  post 'users/confirm' => 'users#confirm'
  
  resources :questions

  resources :advertisements

  get 'about' => 'welcome#about'

  root 'welcome#index'

end
