class StudentSlotSerializer
  attr_reader :slot

  def initialize(slot)
    @slot = slot
  end

  def as_json(options = {})
    {
      id: slot.id,
      title: "Booked with #{slot.coach.name} (#{slot.coach.phone})",
      phone: slot.coach.phone,
      start: slot.start,
      end: slot.end,
    }
  end
end
