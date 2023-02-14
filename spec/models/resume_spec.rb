require "rails_helper"

RSpec.describe Resume, type: :model do
  subject { build :resume }

  it { should validate_presence_of(:title) }
  it { should validate_uniqueness_of(:title).case_insensitive }

  it { should belong_to(:user) }
end
