require 'rails_helper'

RSpec.describe Slot, type: :model do
  subject { build(:slot) }

  describe 'associations' do
    it { should belong_to(:coach) }
    it { should belong_to(:student).optional }
  end
end
