class Admin < ActiveRecord::Base
  has_and_belongs_to_many :site_setting_logs

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

  def full_name
    "#{first_name} #{last_name}"
  end
end
