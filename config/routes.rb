Rails.application.routes.draw do

  get 'summary/index'

  get 'summary/new'

  get 'summary/show'

  get 'summary/edit'

  devise_for :users
  
  resources :topics do
    resources :posts, except: [:index]
  end

  resources :summary
  
  get 'about' => 'welcome#about'
  root to: 'welcome#index'

end
