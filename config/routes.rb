Rails.application.routes.draw do
	resources :tasks
	devise_for :users
	# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
	root 'tasks#index'
	namespace :api , defaults: {format: 'json'} do
		namespace :v1 do
			post '/users/registrations' => 'registrations#create'
			post '/users/sessions' => 'sessions#create'
			get '/tasks' => 'tasks#index'
			post '/tasks' => 'tasks#create'
			delete '/tasks/:id' => 'tasks#destroy'
		end
	end
end
