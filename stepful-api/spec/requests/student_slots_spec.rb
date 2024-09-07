require 'swagger_helper'

RSpec.describe 'student slots', type: :request do
  let!(:coach) { create(:coach) }
  let!(:student) { create(:student) }
  let!(:other_coach) { create(:coach) }

  let!(:coach_slots) do
    [0, 2, 4].map do |n|
      start_time = Time.current + n.hours
      Slot.create!(coach:, duration: (start_time...(start_time + 2.hours)))
    end
  end

  let!(:other_coach_slots) do
    [6, 8].map do |n|
      start_time = Time.current + n.hours
      Slot.create!(coach: other_coach, duration: (start_time...(start_time + 2.hours)))
    end
  end

  let!(:student_slots) do
    coach_slots.first.update!(student:)
    other_coach_slots.last.update!(student:)
  end

  path '/students/{student_id}/slots' do
    get('list student slots') do
      tags 'Slots'
      operationId 'listStudentSlots'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :student_id, in: :path, type: :string

      let(:student_id) { student.id }

      response(200, 'successful') do
        schema type: :object, required: ['data'], properties: {
          data: {
            type: :array,
            items: { '$ref' => '#/components/schemas/Slot' },
          },
        }

        run_test! do |response|
          expect(JSON.parse(response.body)['data'].length).to eq(2)
        end
      end
    end
  end

  path '/students/{student_id}/slots/{slot_id}' do
    put('join slot') do
      tags 'Slots'
      operationId 'joinSlot'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :student_id, in: :path, type: :string
      parameter name: :slot_id, in: :path, type: :string

      let(:slot) { coach_slots.last }
      let(:student_id) { student.id }
      let(:slot_id) { slot.id }

      response(200, 'successful') do
        schema type: :object, required: ['data'], properties: {
          data: { '$ref' => '#/components/schemas/Slot' },
        }

        run_test! do |response|
          expect(JSON.parse(response.body)['data']['id']).to eq(slot.id)
        end
      end
    end
  end
end
