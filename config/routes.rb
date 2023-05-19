# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'home#language_redirection'

  scope '/:locale' do
    devise_for :users

    get '/', to: 'home#index'
  end
end
