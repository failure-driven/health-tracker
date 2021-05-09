module Mutations
  class UpsertStat < BaseMutation
    argument :date, String, required: true
    argument :data, GraphQL::Types::JSON, required: true

    field :daily_stat, Types::DailyStatType, null: false
    field :errors, [String], null: false

    def resolve(date:, data:)
      current_user = context[:current_user]
      daily_stat = DailyStat.find_or_create_by(date: Date.parse(date), user_id: current_user.id)
      daily_stat.data = data

      if daily_stat.save
        {
          daily_stat: daily_stat,
          errors: [],
        }
      else
        {
          daily_stat: nil,
          errors: daily_stat.errors.full_messages,
        }
      end
    end
  end
end
