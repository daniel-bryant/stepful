class CoachSlotsController < ApplicationController
  DEFAULT_LENGTH = 2.hours

  before_action :find_coach

  def index
    slots = @coach.slots.order(:duration)

    render json: {
      data: slots.map { |slot|
        CoachSlotSerializer.new(slot)
      }
    }
  end

  def create
    slot = @coach.slots.create!(slot_params)

    render json: {
      data: CoachSlotSerializer.new(slot),
    }
  end

  private

  def find_coach
    @coach = Coach.find(params[:coach_id])
  end

  def slot_params
    sp = params.require(:slot).permit(:start)
    start_time = Time.parse(sp[:start])
    { duration: start_time...(start_time + DEFAULT_LENGTH) }
  end
end
