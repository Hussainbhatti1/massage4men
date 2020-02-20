class Admin < ActiveRecord::Base
  devise  :database_authenticatable,
          :rememberable,
          :trackable,
          :validatable
          
  validates :role,
            presence: true,
            numericality: true,
            inclusion: {in: [ROLE_MODERATOR, ROLE_ADMIN]}

  def is_admin?
    role == ROLE_ADMIN
  end
end
