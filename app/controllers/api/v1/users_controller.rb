module Api
  module V1
    class UsersController < ApplicationController
      before_action :jwt_authenticate, except: [:create, :token]

      def create
        user = User.new(user_params)
        if user.save
          render json: { token: get_jwt(user.id) }, status: 200
        else
          render json: user.errors, status: 400
        end
      end

      def edit
        if @current_user.update(user_params)
          render json: UserSerializer.new(@current_user).to_json, status: 200
        else
          render json: @current_user.errors, status: 400
        end
      end

      def show
        render json: UserSerializer.new(@current_user).to_json, status: 200
      end
      
      def token
        user = User.find_by(email: params[:email])
        if !user || !PasswordSecurity.verify(user.password_digest, params[:password])
          error('Invalid login credentials')
        else
          render json: { token: get_jwt(user.id) }, status: 200
        end
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