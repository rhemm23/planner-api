Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      # Course
      get 'courses', to: 'courses#list'
      get 'courses/:id', to: 'courses#show'
      post 'courses/:id', to: 'courses#edit'
      post 'courses/new', to: 'courses#create'

      # Assignment
      get 'assignments', to: 'assignments#list'
      get 'assignments/:id', to: 'assignments#show'
      post 'assignments/:id', to: 'assignments#edit'
      post 'assignments/new', to: 'assignments#create'

      # User
      get 'users/me', to: 'users#show'
      get 'users/token', to: 'users#token'
      post 'users/edit', to: 'users#edit'
      post 'users/new', to: 'users#new'
    end
  end
end
