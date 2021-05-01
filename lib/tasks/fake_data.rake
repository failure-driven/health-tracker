def create_or_update(model_class, attributes)
  if (model = model_class.find_by(id: attributes[:id]))
    model.attributes = model.attributes.merge(attributes.without(:id))
    model.save! if model.changed?
    model
  else
    model_class.create!(attributes)
  end
end

desc "fake data"
task fake_data: :environment do
  include Rails.application.routes.url_helpers

  [
    {
      email: "akash@health-tracker.com",
      daily_stats: lambda { |user|
                     user.daily_stats.delete_all
                     ((Date.today - 1.year)..Date.today).each do |date|
                       user.daily_stats.create(
                         date: date,
                         data: {
                           "weight (kg)": rand(100..119),
                           "pusups (count)": rand(100..119),
                           "chinups (count)": rand(100..119),
                         },
                       )
                     end
                   },
    },
    {
      email: "michael@health-tracker.com",
      daily_stats: lambda { |user|
                     user.daily_stats.delete_all
                     ((Date.today - 1.year)..Date.today).each do |date|
                       data = {}
                       data["weight (kg)"] = rand(100..119) if rand(100) > 60
                       data["pushups (count)"] = rand(100..119) if rand(100) > 20
                       data["chinups (count)"] = rand(100..119) if rand(100) > 80
                       user.daily_stats.create(
                         date: date,
                         data: data,
                       )
                     end
                   },
    },
  ].each do |setup_data|
    user = create_or_update(
      ::User, {
        id: Digest::UUID.uuid_v5(Digest::UUID::DNS_NAMESPACE, "user_email_#{setup_data[:email]}"),
        email: setup_data[:email],
        password: "1password",
        confirmed_at: DateTime.now,
      },
    )
    setup_data[:daily_stats]&.call(user)
  end
end
