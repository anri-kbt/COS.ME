class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :cosmetics
         
  with_options presence: true do
    validates :first_name
    validates :first_name_kana
    validates :last_name
    validates :last_name_kana
    validates :call_number
    validates :email
  end
  
end
