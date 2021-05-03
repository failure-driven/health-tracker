module Types
  class MutationType < Types::BaseObject
    field :add_daily_stat, mutation: Mutations::AddDailyStat
  end
end
