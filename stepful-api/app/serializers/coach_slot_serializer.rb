class CoachSlotSerializer
  attr_reader :slot

  def initialize(slot)
    @slot = slot
  end

  def as_json(options = {})
    {
      id: slot.id,
      title: title,
      phone: slot.student.present? ? slot.student.phone : '',
      start: slot.start,
      end: slot.end,
    }
  end

  private

  def title
    if slot.student.present?
      return "Booked with #{slot.student.name} (#{slot.student.phone})"
    end

    "Available"
  end
end
