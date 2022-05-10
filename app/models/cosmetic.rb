class Cosmetic < ApplicationRecord
  belongs_to :customer
  belongs_to :brand
  belongs_to :calendar
  belongs_to :category
  has_many :cosme_comments
  accepts_nested_attributes_for :brand
  accepts_nested_attributes_for :category
  has_one_attached :cosmetic_image

  enum public_status: { open: 0, close: 1}

  def get_image
    unless image.attached?
      file_path=Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io:File.open(file_path),filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
      image
  end
end
