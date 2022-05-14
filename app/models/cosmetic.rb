class Cosmetic < ApplicationRecord
  belongs_to :customer
  belongs_to :brand
  belongs_to :calendar ,optional: true
  belongs_to :category
  has_many :cosme_comments, dependent: :destroy

  has_one_attached :cosmetic_image

  with_options presence: true do
    validates :cosmetic_name
    validates :cosmetic_image
    validates :price
    validates :introduction
    validates :evaluation
  end

  enum public_status: { public: 0, private: 1}, _prefix: true

  def self.category
    Cosmetic.where(category_id: @category )
  end

  def get_image
    unless image.attached?
      file_path=Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io:File.open(file_path),filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
      image
  end
end
