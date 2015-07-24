class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  has_many :posts
  has_many :comments
  mount_uploader :avatar, AvatarUploader
  
  def admin?
   self.role == 'admin'
  end
  
  def moderator?
   self.role == 'moderator'
  end
  
end
