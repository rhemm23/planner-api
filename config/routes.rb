Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      # Course
      get 'courses', to: 'courses#list'
      get 'courses/:id', to: 'courses#show'
      post 'courses/:id', to: 'courses#edit'
      post 'courses', to: 'courses#create'

      # Assignment
      get 'assignments', to: 'assignments#list'
      get 'assignments/:id', to: 'assignments#show'
      post 'assignments/:id', to: 'assignments#edit'
      post 'assignments', to: 'assignments#create'

      # User
      get 'users/me', to: 'users#show'
      post 'users/token', to: 'users#token'
      post 'users/edit', to: 'users#edit'
      post 'users', to: 'users#create'

      # Assignment Comments
      get 'assignments/:id/comments', to: 'assignment_comments#list'
      post 'assignments/:id/comments', to: 'assignment_comments#create'
      get 'assignments/:id/comments/:comment_id', to: 'assignment_comments#show'
      post 'assignments/:id/comments/:comment_id', to: 'assignment_comments#edit'
    end
  end
end
