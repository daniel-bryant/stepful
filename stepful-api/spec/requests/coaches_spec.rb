require 'swagger_helper'

RSpec.describe 'coaches', type: :request do
  let!(:coaches) do
    5.times do |n|
      coach = create(:coach, name: "Coach #{n}")
      start_time = Time.current
      Slot.create!(coach:, duration: (start_time...(start_time + 2.hours)))
    end
  end

  path '/coaches' do
    get('list coaches') do
      tags 'Coaches'
      operationId 'listCoaches'
      consumes 'application/json'
      produces 'application/json'

      response(200, 'successful') do
        schema type: :object, required: ['data'], properties: {
          data: {
            type: :array,
            items: { '$ref' => '#/components/schemas/Coach' },
          },
        }

        run_test! do |response|
          expect(JSON.parse(response.body)['data'].length).to eq(5)
        end
      end
    end
  end
end
