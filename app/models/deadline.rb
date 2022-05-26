class Deadline < ApplicationRecord
  belongs_to :shipping_company
  validates :min_distance, :max_distance, :deadline_in_days, presence: true
end
