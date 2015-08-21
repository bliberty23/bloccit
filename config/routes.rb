Rails.application.routes.draw do

  root to: 'welcome#index'
  get 'about', to: 'welcome#about'

  devise_for :users
  
  resources :users, only: [:update, :show]
  
  resources :topics do
    resources :posts, except: [:index] do
      resources :comments, only: [:create, :destroy]
    end
  end

  resources :posts, only: [] do
    resources :comments, only: [:create, :destroy]
    resources :favorites, only: [:create, :destroy]
    post '/up-vote', to: 'votes#up_vote', as: :up_vote
    post '/down-vote', to: 'votes#down_vote', as: :down_vote
  end
end
