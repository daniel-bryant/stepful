require 'swagger_helper'

RSpec.describe 'coach slots', type: :request do
  let!(:coach) { create(:coach) }
  let!(:other_coach) { create(:coach) }

  let!(:coach_slots) do
    [0, 2, 4].map do |n|
      start_time = Time.current + n.hours
      Slot.create!(coach:, duration: (start_time...(start_time + 2.hours)))
    end
  end

  let!(:other_coach_slots) do
    [0, 2].map do |n|
      start_time = Time.current + n.hours
      Slot.create!(coach: other_coach, duration: (start_time...(start_time + 2.hours)))
    end
  end

  path '/coaches/{coach_id}/slots' do
    get('list coach slots') do
      tags 'Slots'
      operationId 'listCoachSlots'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :coach_id, in: :path, type: :string

      let(:coach_id) { coach.id }

      response(200, 'successful') do
        schema type: :object, required: ['data'], properties: {
          data: {
            type: :array,
            items: { '$ref' => '#/components/schemas/Slot' },
          },
        }

        run_test! do |response|
          expect(JSON.parse(response.body)['data'].length).to eq(3)
        end
      end
    end

    post('create coach slot') do
      tags 'Slots'
      operationId 'createCoachSlot'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :coach_id, in: :path, type: :string

      parameter name: :data, in: :body, required: true, schema: {
        type: :object,
        properties: {
          slot: {
            type: :object,
            properties: {
              start: { type: :string },
            },
            required: ['start'],
          },
        },
        required: ['slot']
      }

      let(:coach_id) { coach.id }
      let(:data) { { slot: { start: "2024-10-01T17:00:00Z" } } }

      response(200, 'successful') do
        schema type: :object, required: ['data'], properties: {
          data: { '$ref' => '#/components/schemas/Slot' },
        }

        run_test! do |response|
          expect(JSON.parse(response.body)['data']['id']).to eq(Slot.last.id)
        end
      end
    end
  end
end
