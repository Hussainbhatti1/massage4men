module Mailable
  extend ActiveSupport::Concern
  
  def send_system_email(mail)
    ApplicationMailer.system_email(self, mail).deliver_later
  end
end