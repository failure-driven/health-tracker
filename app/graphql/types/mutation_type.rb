module Types
  class MutationType < Types::BaseObject
    field :upsert_stat, mutation: Mutations::UpsertStat
  end
end
