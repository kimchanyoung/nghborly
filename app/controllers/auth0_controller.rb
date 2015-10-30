class Auth0Controller < ApplicationController
<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> Add the shell for the code that will hand the success and failure of the callback
def callback
    # This stores all the user information that came from Auth0
    # and the IdP
    session[:userinfo] = request.env['omniauth.auth']

    # Redirect to the URL you want after successfull auth
    redirect_to '/dashboard'
<<<<<<< HEAD
  end

  def failure
    # show a failure page or redirect to an error page
    @error_msg = request.params['message']
=======
  def callback
  end

  def failure
>>>>>>> Add the Auth0 callback handler
=======
  end

  def failure
    # show a failure page or redirect to an error page
    @error_msg = request.params['message']
>>>>>>> Add the shell for the code that will hand the success and failure of the callback
  end
end
