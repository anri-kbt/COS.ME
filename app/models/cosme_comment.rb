class CosmeComment < ApplicationRecord
  belongs_to :cosmetic
  belongs_to :customer
end
