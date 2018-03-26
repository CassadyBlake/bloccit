Rails.application.routes.draw do

  resources :topics do
    resources :posts, except: [:index]
  end

  resources :questions

  resources :advertisements

  get 'about' => 'welcome#about'

  root 'welcome#index'

end
