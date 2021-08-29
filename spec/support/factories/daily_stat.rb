FactoryBot.define do
  factory :daily_stat do
    id { |index| index }
    date { DateTime.now - rand(0...1460) }
    data { { weight: 66.0 + rand(0.0...3.0), situps: rand(70...100) } }
  end
end
