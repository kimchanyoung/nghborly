class NewRequestMailer < BaseMandrillMailer
  def notify(request, user)
    subject = "#{request.requester.first_name} needs a neighbor!"
    merge_vars = {
      "REQUEST_URL" => "/requests/#{request.id}",
      "REQUEST_CONTENT" => request.content,
      "FIRST_NAME" => user.first_name
    }
    body = mandrill_template('new_request', merge_vars)

    send_mail(user.email, subject, body)
  end
end