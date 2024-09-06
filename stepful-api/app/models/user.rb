class User < ApplicationRecord
  validates :name, :phone, presence: true
end
