Rails.application.routes.draw do

	post :incoming, to: 'incoming#create'

	resources :topics do
		resources :bookmarks, except: [:index] do
			resources :likes, only: [:index, :create, :destroy]
		end

	end

  devise_for :users, controllers: {registrations: "registrations"}
	resources :users, only: [:show]

	get 'welcome/index'

  get 'about', to: 'welcome#about'

	root 'welcome#index'

end
