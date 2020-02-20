module Unique
  extend ActiveSupport::Concern
  
  # Shared methods between Masseur and Client
  included do
    def screen_name_must_not_be_in_use_by_client_or_masseur
      client = Client.where('lower(screen_name) = ?', screen_name.downcase)
      masseur = Masseur.where('lower(screen_name) = ?', screen_name.downcase)    
    
      if (client.count > 0 && !client.include?(self)) || (masseur.count > 0 && !masseur.include?(self))
        errors.add(:screen_name, 'has already been taken')
      end
    
    end

    def email_must_not_be_in_use_by_client_or_masseur
      client = Client.find_by(email: email)
      masseur = Masseur.find_by(email: email)
    
      if (client && client != self) || (masseur && masseur != self)    
        errors.add(:email, 'has already been taken')
      end
    end
  end
end