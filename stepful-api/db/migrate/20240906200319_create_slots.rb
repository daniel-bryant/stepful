class CreateSlots < ActiveRecord::Migration[7.2]
  def change
    enable_extension 'btree_gist' unless extension_enabled?('btree_gist')
    create_table :slots do |t|
      t.timestamps
      t.belongs_to :coach, null: false, foreign_key: { to_table: :users }, index: false
      t.belongs_to :student, null: true, foreign_key: { to_table: :users }, index: false
      t.tsrange :duration, null: false
    end
    add_exclusion_constraint :slots, "coach_id WITH =, duration WITH &&", using: :gist, name: "no_coach_slot_overlap"
    add_exclusion_constraint :slots, "student_id WITH =, duration WITH &&", using: :gist, name: "no_student_slot_overlap"
  end
end
