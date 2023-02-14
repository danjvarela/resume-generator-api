require "rails_helper"

RSpec.describe Job, type: :model do
  subject { build :job }

  it { should validate_presence_of(:title) }
  it { should validate_uniqueness_of(:title).case_insensitive }

  it { should belong_to(:company) }

  it { should belong_to(:user) }

  it { should validate_presence_of(:start_date) }
  it "is expected to not save when start_date is a future date" do
    expect(build(:job, start_date: Date.today + 1.day).save).to eq false
  end

  it "is expected to not save when end_date is a future date" do
    expect(build(:job, end_date: Date.today + 1.day).save).to eq false
  end
end
