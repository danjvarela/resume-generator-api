require 'rails_helper'

RSpec.describe Skill, type: :model do
  subject {create :skill}
  it {should validate_presence_of :name}
  it {should have_many(:users).through(:user_skills)}
  it {should validate_uniqueness_of(:name).case_insensitive}
end
