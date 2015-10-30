class NewRequestMailer < BaseMandrillMailer
  def notify(request, user)
    subject = "#{request.requester.first_name} needs a neighbor!"
    merge_vars = {
      ""
    }
    body = mandrill_template('new_request', merge_vars)

    send_mail(user.email, subject, body)
  end
end