FactoryBot.define do
  factory :user do
    id { |index| index }
    factory :user_claudia do
      email { "claudia.king@automio.com" }
      password { "1password" }
      confirmed_at { DateTime.now }
    end

    factory :user_with_daily_stats do
      transient do
        posts_count { 5 }
      end

      daily_stats do
        Array.new(posts_count) { association(:daily_stat) }
      end
    end
  end
end
