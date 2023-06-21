# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # devise_for :users, skip: [:registrations]
  devise_for :users, skip: [:registrations],
                     path: 'accounts',
                     path_names: { sign_in: 'login', sign_out: 'logout' },
                     controllers: { sessions: 'users/sessions' }

  root to: 'dashboard/dashboard#index'

  namespace :dashboard do
    root                        to: 'dashboard#index'
    get   'users/lists',        to: 'users#lists',        as: 'users_lists'
    get   'users/search',       to: 'users#search',       as: 'users_search'
    get   'detections/search',  to: 'detections#search',  as: 'detections_search'
    patch 'users/activate/:id', to: 'users#activate',     as: 'user_activate'

    resources :users
    resources :detections, only: %i[index create]
    resources :detection_results, only: %i[index show]
  end
end
