module Types
  class DailyStatType < Types::BaseObject
    field :id, ID, null: false
    field :date, GraphQL::Types::ISO8601DateTime, null: false
    field :data, GraphQL::Types::JSON, null: false
  end
end
