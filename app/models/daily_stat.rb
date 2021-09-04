class DailyStat < ApplicationRecord
  belongs_to :user

  validates :date, uniqueness: {scope: :user_id, message: "should have unique date per user"}

  default_scope { order(date: :asc) }

  def data=(value)
    self[:data] = value.is_a?(String) ? JSON.parse(value) : value
  end
end
