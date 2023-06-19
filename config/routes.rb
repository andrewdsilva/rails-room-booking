# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'home#language_redirection'

  scope '/:locale' do
    devise_for :users

    get '/', to: redirect("/%{locale}/rooms")

    resources :rooms, param: :slug do
      collection do
        get ":scope", to: "rooms#index", as: "scoped", constraints: { scope: "my" }
      end
    end

    resources :bookings do
      member do
        post "cancel"
      end
    end

    resource :settings, only: ["edit", "update"]

    mount ::Payify::Engine => ""
  end
end
