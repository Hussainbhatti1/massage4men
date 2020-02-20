# Preview all emails at http://localhost:3000/rails/mailers/masseur_mailer
class MasseurMailerPreview < ActionMailer::Preview
  def badge_approved
    MasseurMailer.badge_approved_email(Masseur.first, 'Certified Therapist', 'certified')
  end
  
  def one_week_rebill_notice
    MasseurMailer.one_week_rebill_notice_email(Masseur.first)
  end
  
  def day_of_rebill_notice
    MasseurMailer.day_of_rebill_notice_email(Masseur.first)
  end
  
  def notify_masseur_of_new_review
    MasseurMailer.notify_masseur_of_new_review_email(Review.first)
  end
  
  def notify_admin_for_approval
    MasseurMailer.notify_admin_for_approval_email(Masseur.first)
  end
  
  def completion_reminder
    MasseurMailer.completion_reminder(Masseur.last, Masseur.last.calculate_completeness)
  end
end
