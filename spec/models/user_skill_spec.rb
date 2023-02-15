require "rails_helper"

RSpec.describe UserSkill, type: :model do
  subject { create :user_skill }
  it { should belong_to :user }
  it { should belong_to :skill }
  it { should validate_presence_of :years_of_experience }
  it { should validate_uniqueness_of(:skill_id).scoped_to(:user_id) }
end
