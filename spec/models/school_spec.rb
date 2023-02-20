require "rails_helper"

RSpec.describe School, type: :model do
  subject { build :school }

  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name).case_insensitive.scoped_to(:location) }
  it { should have_many(:educations) }

  it "should capitalize name before saving" do
    school = build(:school)
    school.name.downcase!
    school.save

    expect(School.find(school.id).name).to eq school.name.capitalize
  end
end
