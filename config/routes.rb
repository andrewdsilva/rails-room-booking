# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'home#language_redirection'

  scope '/:locale' do
    devise_for :users

    get '/', to: redirect("/%{locale}/rooms")

    resources :rooms, param: :slug
    resources :bookings
  end
end
