module Mutations
  class AddDailyStat < BaseMutation
    argument :date, String, required: true
    argument :data, GraphQL::Types::JSON, required: true

    field :daily_stat, Types::DailyStatType, null: false
    field :errors, [String], null: false

    def resolve(date:, data:)
      current_user = context[:current_user]
      # find previous stat or create new
      daily_stat = DailyStat.find_by(date: Date.parse(date), user_id: current_user.id)
      if daily_stat.nil?
        daily_stat = current_user.daily_stats.new(date: Date.parse(date), data: data)
      else
        daily_stat = DailyStat.find_by(date: date, user_id: current_user.id)
        current_data = daily_stat.data
        data.each do |name, value|
          current_data[name] = value
        end
        daily_stat.data = current_data
      end

      if daily_stat.save
        {
          daily_stat: daily_stat,
          errors: []
        }
      else
        {
          daily_stat: nil,
          errors: daily_stat.errors.full_messages
        }
      end
    end
  end
end
