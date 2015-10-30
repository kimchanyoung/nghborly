class Auth0Controller < ApplicationController
def callback

    user = User.find_or_create_by(userinfo: request.env['omniauth.auth']['userinfo'])

    user.name = request.env['omniauth.auth']['info']['name']
    user.save

    session[:userinfo] = user.userinfo

    redirect_to '/'
  end

  def failure
    @error_msg = request.params['message']
  end
end
