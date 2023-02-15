RSpec.shared_examples "response status" do |status_code|
  it "should return with status #{status_code}" do
    expect(status).to eq status_code
  end
end

RSpec.shared_examples "error response" do
  it "should return with error" do
    expect(json_body.keys).to include("errors")
  end
end
