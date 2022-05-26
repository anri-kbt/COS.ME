class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :cosmetics, dependent: :destroy
  has_many :cosme_comments, dependent: :destroy
  has_many :calendars, dependent: :destroy

  has_one_attached :profile_image

  with_options presence: true do
    validates :nickname
    validates :user_id ,uniqueness: true
    validates :call_number
    validates :email
  end
  validates :nickname, length:{minimum:2 ,maximum:15}

  def active_for_authentication?
    super && (is_deleted == false)
  end

  def get_profile_image(width,height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image2.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end

end
