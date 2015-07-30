Rails.application.routes.draw do

  root to: 'welcome#index'
  get 'about', to: 'welcome#about'

  devise_for :users
  
  resources :users, only: [:update]
  
  resources :topics do
    resources :posts, except: [:index]
  end

  resources :posts, only: [] do
    resources :comments, only: [:create, :destroy]
    post '/up-vote', to: 'votes#up_vote', as: :up_vote
    post '/down-vote', to: 'votes#down_vote', as: :down_vote
  end
end
