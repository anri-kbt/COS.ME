class Calendar < ApplicationRecord
    has_many :calendar_cosmes, dependent: :destroy
    has_many :cosmetics ,through: :calendar_cosmes ,dependent: :destroy
    belongs_to :customer



    def self.print_dates(year,month)
        dates = (Date.new(year,month, 1)...Date.new(year,month + 1, 1)).to_a
        dates.each do |d|
            d
        end
    end

end
