class SlotSerializer
  attr_reader :slot

  def initialize(slot)
    @slot = slot
  end

  def as_json(options = {})
    {
      id: slot.id,
      title: "Available with #{slot.coach.name}",
      phone: '',
      start: slot.start,
      end: slot.end,
    }
  end
end
