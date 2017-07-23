Rails.application.routes.draw do

	post :incoming, to: 'incoming#create'

	resources :topics do
		resources :bookmarks, except: [:index]
	end

  devise_for :users, controllers: {registrations: "registrations"}

	get 'welcome/index'

  get 'about', to: 'welcome#about'

	root 'welcome#index'

end
