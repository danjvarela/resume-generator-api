RSpec.shared_examples "has the correct job attributes" do
  it "has the correct job attributes" do
    expect(job.keys).to include("title", "start_date", "end_date", "city", "description", "created_at", "updated_at")
  end
end

RSpec.shared_examples "contains the related company" do
  it "contains the related company" do
    expect(job["company"].keys).not_to be_empty
  end
end

RSpec.shared_examples "a job" do
  include_examples("has the correct job attributes")
  include_examples("contains the related company")
end
