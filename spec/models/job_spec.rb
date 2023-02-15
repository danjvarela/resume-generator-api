require "rails_helper"

RSpec.describe Job, type: :model do
  subject { build :job }

  it { should validate_presence_of(:title) }
  it { should validate_uniqueness_of(:title).case_insensitive }

  it { should belong_to(:company) }

  it { should belong_to(:user) }

  it { should validate_presence_of(:start_date) }

  it "should to not save when start_date is a future date" do
    expect(build(:job, start_date: Date.today + 1.day).save).to eq false
  end

  it "should to not save when end_date is a future date" do
    expect(build(:job, end_date: Date.today + 1.day).save).to eq false
  end

  it "should create company if no company with name=company_name exists" do
    expect do
      create(:job, company: nil, company_name: generate(:company_name))
    end.to change { Company.count }.by(1)
  end

  it "should ignore company_name if company or company_id is provided" do
    company_name = generate(:company_name)
    create(:job, company_name: company_name)
    expect(Company.find_by(name: company_name)).to be_nil
  end
end
