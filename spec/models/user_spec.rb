require "rails_helper"

RSpec.describe User, type: :model do
  subject { build :user }
  it { should have_many(:jobs).dependent(:destroy) }
  it { should have_many(:skills).through(:user_skills) }
  it { should have_many(:resumes).dependent(:destroy) }
  it { should have_many(:user_skills).dependent(:destroy) }
end
