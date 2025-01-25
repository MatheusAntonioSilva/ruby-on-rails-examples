Rails.application.routes.draw do

  root to: 'v0/books#index'

  scope 'v0' do
    devise_for :users, controllers: { sessions: 'v0/users/sessions', registrations: 'v0/users/registrations' }
  end

  namespace 'v0' do
    resources :books, only: [:create, :update, :show, :index, :destroy]
    get 'favorites/books', to: 'users_favorite_books#index'
    post 'favorites/books', to: 'users_favorite_books#create'
    delete 'favorites/books/:book_id', to: 'users_favorite_books#destroy'
  end
end
