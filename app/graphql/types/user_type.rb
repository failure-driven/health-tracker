module Types
  class UserType < Types::BaseObject
    field :id, ID, null: false
    field :email, String, null: false
    field :daily_stats, [Types::DailyStatType], null: true
  end
end
