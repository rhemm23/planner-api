class ApplicationController < ActionController::API
  def jwt_authenticate
    header = request.headers['authorization']
    if !header.nil?
      parts = header.split(' ')
      if parts.length == 2
        begin
          decoded_token = JWT.decode parts[1], ENV['API_SECRET'], true, { algorithm: 'HS256' }
          @current_user = User.find_by(id: decoded_token[0]['user_id'])
          return if @current_user
        rescue JWT::DecodeError
          # Invalid token
        end
      end
    end
    head 401
  end

  def get_jwt
    payload = { user_id: @current_user.id }
    JWT.encode payload, ENV['API_SECRET'], 'HS256'
  end

  def error(message, status_code = 400)
    render json: { error: message }, status: status_code
  end
end
