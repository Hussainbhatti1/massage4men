class DeviseCustomMailer < Devise::Mailer
  default from: "Massage4Men <noreply@m4m.net>"
  layout 'mailer'
  
  helper :application
  include Devise::Controllers::UrlHelpers
end
