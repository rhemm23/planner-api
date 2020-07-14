module Api
  module V1
    class UsersController < ApplicationController
      before_action :jwt_authenticate, except: [:create]

      def create
        user = User.new(user_params)
        if user.save
          @current_user = user
          render json: { token: get_jwt }, status: 200
        else
          render json: user.errors, status: 400
        end
      end

      def edit
        if @current_user.update(user_params)
          render json: @current_user, status: 200
        else
          render json: @current_user.errors, status: 400
        end
      end

      def show
        render json: @current_user, status: 200
      end
      
      def token
        render json: { token: get_jwt }, status: 200
      end

      private

      def user_params
        params.permit(
          :email,
          :password,
          :password_confirmation
        )
      end
    end
  end
end