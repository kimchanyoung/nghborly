class NewResponderMailer < BaseMandrillMailer
  def notify(request, user)
    subject = "#{request.responder.first_name} has replied to your request!"
    merge_vars = {
      "REQUEST_URL" => "/requests/#{request.id}",
      "REQUESTER_FNAME" => request.requester.first_name,
      "RESPONDER_FNAME" => user.first_name
    }
    body = mandrill_template('new_responder', merge_vars)

    send_mail(user.email, subject, body)
  end
end