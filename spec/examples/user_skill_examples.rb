RSpec.shared_examples "has the correct user_skill attributes" do
  it "has the correct user_skill attributes" do
    expect(user_skill.keys).to include("id", "years_of_experience", "name")
  end
end

RSpec.shared_examples "contains the related skill" do
  it "contains the related skill" do
    expect(user_skill["skill"].keys).not_to be_empty
  end
end

RSpec.shared_examples "a user_skill" do
  include_examples("has the correct user_skill attributes")
  include_examples("contains the related skill")
end
