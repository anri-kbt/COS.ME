class CosmeComment < ApplicationRecord
  belongs_to :cosmetics
  belongs_to :customer
end
