require "rails_helper"

RSpec.describe Company, type: :model do
  subject { build :company }

  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name).case_insensitive }
  it { should have_many(:jobs) }
end
