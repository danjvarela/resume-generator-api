require 'rails_helper'

RSpec.describe Education, type: :model do
  subject { build :education }

  it { should validate_presence_of(:level) }
  it { should validate_presence_of(:field_of_study) }
  it { should belong_to(:school) }
  it { should validate_presence_of(:start_date) }
  it { should belong_to(:user) }
end
