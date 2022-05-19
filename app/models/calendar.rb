class Calendar < ApplicationRecord
    has_many :calendar_cosmes, dependent: :destroy
    has_many :cosmetics ,through: :calendar_cosmes
    
end
