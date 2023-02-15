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
    original_company_count = Company.count
    job = create(:job, company: nil, company_name: generate(:company_name))
    expect(job.persisted?).to eq true
    expect(Company.count).to eq original_company_count + 1
  end

  it "should ignore company_name if company or company_id is provided" do
    original_company_count = Company.count
    company_name = generate(:company_name)
    job = create(:job, company_name: company_name)
    expect(job.persisted?).to eq true
    expect(Company.find_by(name: company_name)).to be_nil
  end
end
