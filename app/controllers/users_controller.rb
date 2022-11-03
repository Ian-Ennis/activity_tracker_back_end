class UsersController < ApplicationController
  skip_before_action :require_login, only: [:create]
  before_action :require_login, only: [:updated_at]

  def create
      puts "=== in Users create"
      user = User.create!(user_params)
      if user.valid?
        puts "=== user is valid"
        payload = {
          user_id: user.id,
          iat: Time.now
        }
        puts payload
        token = encode_token(payload)
        render json: {user: user, include: [jwt: token]}, status: :ok
      else
        render json: {errors: user.errors.full_messages}, status: :not_acceptable
      end
  end

  private

  def user_params
    puts "=== in users params"
    params.permit(:username, :password)
  end

end
