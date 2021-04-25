class DailyStat < ApplicationRecord
  belongs_to :user

  validates :date, uniqueness: { scope: :user_id, message: "should have unique date per user" }
end
