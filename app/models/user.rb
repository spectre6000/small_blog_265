# Model for Authors/Commentors
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :lockable, :validatable

  validates :username, :email, presence: true
  # Images/Paperclip
  # Profile image
  has_attached_file :profile_image,
                    styles: {
                      index_profile: '200x200#',
                      show_profile: '500x500#',
                      original: '500x500#'
                    },
                    default_url: '/images/:style/missing.png'
  validates_attachment_content_type :profile_image,
                                    content_type: %r{\Aimage\/.*\Z}
  # Banner image
  has_attached_file :banner_image,
                    styles: {
                      index_banner: '1500x300#',
                      original: '1500x300^'
                    },
                    default_url: '/images/:style/missing.png'
  validates_attachment_content_type :banner_image,
                                    content_type: %r{\Aimage\/.*\Z}
  has_many :articles

  scope :confirmed_users, -> { User.where.not(confirmed_at: nil) }
end
