Rails.application.routes.draw do
	get 'rooms/show'
	root :to => 'home#index'

	get 'home/about', to: 'home#new'

	devise_for :users, controllers: {
		sessions: 'users/sessions',
		registrations: 'users/registrations'
	}
	resources :rooms
	resources :users do
		get 'search', on: :member
	end
	get 'search', to:'users#search'

	resources :books do
		resource :book_comments,only: [:create, :destroy]
		resource :favorites,only: [:create, :destroy]
	end

	resources :relationships, only: [:create, :destroy]
# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
