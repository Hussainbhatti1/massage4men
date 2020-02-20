# Preview all emails at http://localhost:3000/rails/mailers/admin_mailer
class AdminMailerPreview < ActionMailer::Preview
  def notify_admin_of_rejected_review
    AdminMailer.notify_admin_of_rejected_review(Review.first)
  end
  
  def new_client_signup
    AdminMailer.new_client_signup(Client.first)
  end
  
  def new_client_signup_from_short_form
    AdminMailer.new_client_signup(Client.new(email: 'tim@atomicpromise.com', 
    password: 'p4ssw0rD!',
    age_verified: '1',
    created_at: Time.now))
  end
end
