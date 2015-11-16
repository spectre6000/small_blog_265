class Author < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :lockable, :validatable

  validates :username, :email, presence: true
  # Images/Paperclip
  # Profile image
  has_attached_file :profile_image, styles: { medium: "300x300#", thumb: "100x100#" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :profile_image, content_type: /\Aimage\/.*\Z/
  # Banner image
  has_attached_file :banner_image, styles: { medium: "300x300#", thumb: "100x100#" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :banner_image, content_type: /\Aimage\/.*\Z/
  
end