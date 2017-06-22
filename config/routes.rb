Rails.application.routes.draw do

	resources :topics

  devise_for :users, controllers: {registrations: "registrations"}

	get 'welcome/index'

  get 'about', to: 'welcome#about'

	root 'welcome#index'

end
