module Types
  class QueryType < Types::BaseObject
    description "The query root of this schema"

    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    field :daily_stat_by_id, DailyStatType, null: true do
      description "get daily stats of the user by daily stats id"
      argument :id, ID, required: true
    end

    def daily_stat_by_id(id:)
      DailyStat.find(id: id, user_id: context[:current_user].id)
    end

    field :daily_stats, [DailyStatType], null: true do
      description "get all daily stats of the current user"
    end

    def daily_stats
      current_user = context[:current_user]
      current_user.daily_stats
    end
  end
end
