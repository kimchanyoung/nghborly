class GeneralNotificationMailer < BaseMandrillMailer
  def notify(text, email)
    subject = "A message from your nghbors at nghbor.ly"
    merge_vars = {
      "BODY" => text
    }
    body = mandrill_template('general-notification', merge_vars)

    send_mail(email, subject, body)
  end
end