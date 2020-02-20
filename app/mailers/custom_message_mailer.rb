class CustomMessageMailer < Mailboxer::MessageMailer
  default :from => 'Massage4Men <noreply@m4m.net>'
  layout 'mailer'
end
