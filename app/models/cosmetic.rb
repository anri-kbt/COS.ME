class Cosmetic < ApplicationRecord
  belongs_to :customer
  belongs_to :brand
  belongs_to :category
  has_many :cosme_comments
  has_many :calendar_cosmes
  has_many :calendars, through: :calendar_cosmes
  has_many :favorites
  
  

  has_one_attached :cosmetic_image

  with_options presence: true do
    validates :cosmetic_name
    validates :cosmetic_image
    validates :price
    validates :introduction
    validates :evaluation
  end
  validates :cosmetic_name, length:{ maximum:30}

  enum public_status: { public: 0, private: 1}, _prefix: true

  scope :public_status, -> { where(public_status: 0).order(id: :desc) }

  def self.category
    Cosmetic.where(category_id: @category )
  end

  def get_cosmetic_image
    cosmetic_image
  end

  def favorited_by?(customer)
    favorites.exists?(customer_id: customer.id)
  end

end
