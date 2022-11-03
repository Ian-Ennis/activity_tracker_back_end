class ApplicationController < ActionController::API
  before_action :require_login

  def encode_token(payload)
    JWT.encode(payload, 'zcx8u9xzc9u8dsau89dsajo')
  end

  def auth_header
    request.headers['Authorization'].split(' ')[1]
  end

  def decoded_token
    if auth_header
      begin
        JWT.decode(auth_header, 'zcx8u9xzc9u8dsau89dsajo', true, algorithm: 'HS256')
      rescue JWT::DecodeError
        []
      end
    end
  end

  def session_user
    decoded_hash = decoded_token
    if !decoded_hash.empty?
      user_id = decoded_hash[0]['user_id']
      @user = User.find_by(id: user_id)
    else
      nil
    end
  end

  def logged_in?
    !!session_user
  end

  def require_login
    render json: {message: 'Please Login'}, status: :unauthorized unless logged_in?
   end

end
