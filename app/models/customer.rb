class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :cosmetics, dependent: :destroy
  has_many :cosme_comments, dependent: :destroy
  
  has_one_attached :profile_image

  with_options presence: true do
    validates :first_name
    validates :first_name_kana
    validates :last_name
    validates :last_name_kana
    validates :call_number
    validates :email
  end

  def full_name
    self.last_name + " " + self.first_name
  end
  def active_for_authentication?
    super && (is_deleted == false)
  end

end
