require 'rails_helper'

RSpec.describe UserSkill, type: :model do
  it {should belong_to :user}
  it {should belong_to :skill}
  it {should validate_presence_of :years_of_experience}
end
