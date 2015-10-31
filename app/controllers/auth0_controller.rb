class Auth0Controller < ApplicationController
  def callback

    user = User.find_or_create_by(user_id: request.env['omniauth.auth']['uid'])

    user.first_name = request.env['omniauth.auth']['info']['last_name']
    user.last_name = request.env['omniauth.auth']['info']['first_name']
    user.email = request.env['omniauth.auth']['info']['email']
    user.save

    session[:user_id] = user.user_id

    redirect_to root_path
  end

  def failure
    @error_msg = request.params['message']
  end
end
