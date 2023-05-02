class SessionsController < ApplicationController
#   skip_before_action :authenticate, only: [:login]

  def login
    user = User.find_by(username: login_params["username"])
    if user.nil?
        render json: { message: "Couldn't find user"}
        return
    end

    if user.authenticate(login_params["password"])
        payload = {user_id: user.id}
        render json: {
            id: user.id,
            username: user.username,
            token: create_token(payload)
        }
    else
        render json: { message: "Incorrect password"}
    end

  end

  private
  
  def login_params
    params.permit(:username, :password)
  end
end
