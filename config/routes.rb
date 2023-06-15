# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # devise_for :users, skip: [:registrations]
  devise_for :users, skip: [:registrations], path: 'accounts', path_names: { sign_in: 'login', sign_out: 'logout' }

  root to: 'dashboard/dashboard#index'

  namespace :dashboard do
    root to: 'dashboard#index'
    resources :users
    resources :detections, only: %i[index create]
    resources :detection_reports, only: [:index]
  end
end
