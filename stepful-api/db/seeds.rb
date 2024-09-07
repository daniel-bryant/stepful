# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

john = Coach.create!(name: "John McGuirk", phone: "2025551231")
lynch = Coach.create!(name: "Mr. Lynch", phone: "2025551232")
brendon = Student.create!(name: "Brendon Small", phone: "2025551233")

time = Time.current

[0, 2].each do |h|
  start_time = time + h.hours
  Slot.create!(coach: john, duration: (start_time...(start_time + 2.hours)))
end

[4, 6].each do |h|
  start_time = time + h.hours
  Slot.create!(coach: lynch, duration: (start_time...(start_time + 2.hours)))
end

john.slots.order(:id).first.update!(student: brendon)
lynch.slots.order(:id).last.update!(student: brendon)

bad_time = time + 1.hour
begin
  Slot.create!(coach: john, duration: (bad_time..(bad_time + 2.hours)))
  # We should not get here - PG should fail with:
  # conflicting key value violates exclusion constraint "no_coach_slot_overlap"
  raise 'Postgres is missing a constraint'
rescue ActiveRecord::StatementInvalid
end

short_time = time + 10.hours
begin
  Slot.create!(coach: john, duration: (short_time..(short_time + 1.hours)))
  raise 'Rails is missing a validation'
rescue ActiveRecord::RecordInvalid
end

# Separate coaches can overlap hours
same_time = time + 12.hours
Slot.create!(coach: john, duration: (same_time...(same_time + 2.hours)))
Slot.create!(coach: lynch, duration: (same_time...(same_time + 2.hours)))
