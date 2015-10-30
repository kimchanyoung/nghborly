class NewRequestMailer < BaseMandrillMailer
  def notify(request, user_id)
    user = User.find(user_id)
    subject = "#{request.requester.first_name} needs a neighbor!"
    merge_cars = {

    }
    body = mandrill_template('new_request', merge_vars)

    send_mail(user.email, subject, body)
  end
end