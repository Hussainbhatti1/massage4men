class Email < ActiveRecord::Base
  # Add virtual attributes found in body text when loading
  after_find do |email|
    email.variables.each do |var|
      email.class_eval { attr_accessor var.downcase.to_sym }
    end
  end
  
  # Add a virtual attribute for a Client or Masseur this will be sent to
  attr_accessor :recipient
  
  validates :subject, :body,
            presence: true

  def variables
    body.scan(/\{\$(.*?)\}/).map { |match| match.first }
  end

  # def send
  #   # Sends this email to a provided recipient.
  # end
end
