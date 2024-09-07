class StudentSlotsController < ApplicationController
  DEFAULT_LENGTH = 2.hours

  before_action :find_student
  before_action :find_slot, only: :update

  def index
    slots = @student.slots.order(:duration)

    render json: {
      data: slots.map { |slot|
        StudentSlotSerializer.new(slot)
      }
    }
  end

  def update
    @slot.update!(student: @student)

    render json: {
      data: StudentSlotSerializer.new(@slot),
    }
  end

  private

  def find_student
    @student = Student.find(params[:student_id])
  end

  def find_slot
    @slot = Slot.where(student: nil).find(params[:id])
  end
end
