class Calendar < ApplicationRecord
    has_many :calendar_cosmes, dependent: :destroy
    has_many :cosmetics, through: :calendar_cosmes, dependent: :destroy
    belongs_to :customer

    with_options presence: true do
        validates :used_date
  end

end
