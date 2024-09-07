class CoachesController < ApplicationController
  def index
    coaches = Coach.order(:name)

    render json: {
      data: coaches.map { |coach|
        CoachSerializer.new(coach)
      }
    }
  end
end
