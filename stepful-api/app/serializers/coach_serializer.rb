class CoachSerializer
  attr_reader :coach

  def initialize(coach)
    @coach = coach
  end

  def as_json(options = {})
    {
      id: coach.id,
      name: coach.name,
      slots: coach.slots.where(student_id: nil).order(:duration).map { |slot|
        SlotSerializer.new(slot)
      },
    }
  end
end
