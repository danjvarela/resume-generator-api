require "rails_helper"

RSpec.describe User, type: :model do
  it { should have_many(:jobs).dependent(:destroy) }
  it { should have_many(:skills).through(:user_skills) }
  it { should have_many(:resumes).dependent(:destroy) }
  it { should have_many(:user_skills).dependent(:destroy) }
  it { should validate_presence_of(:phone_number) }
  it { should validate_presence_of(:address) }
end
