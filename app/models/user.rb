class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  scope :participants, -> {where role: UsersHelper::ParticipantUser}
  after_create :generate_auth_token
  
  def role_name
  	UsersHelper::ROLES[self.role]
  end

  def is_role?(role)
  	self.role == role
  end

  def generate_auth_token
    token = SecureRandom.hex
    self.update_columns(auth_token: token)
    token
  end

  def invalidate_auth_token
    self.update_columns(auth_token: nil)
  end
end
