FactoryBot.define do
  factory :slot do
    coach
    duration do
      start_time = 1.hour.from_now
      start_time..(start_time + 2.hours)
    end
  end
end
