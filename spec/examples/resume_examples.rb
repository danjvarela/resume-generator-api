RSpec.shared_examples "has the correct resume attributes" do
  it "has the correct resume attributes" do
    expect(resume.keys).to include("title", "headline", "summary")
  end
end

RSpec.shared_examples "a resume" do
  include_examples("has the correct resume attributes")
end
