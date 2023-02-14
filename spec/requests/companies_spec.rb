require "rails_helper"
require "contexts/authenticate_user"
require "examples/response_examples"
require "examples/job_examples"

RSpec.shared_examples "has the correct company attributes" do
  it "has the correct company attributes" do
    expect(company.keys).to include("id", "name")
  end
end

RSpec.shared_examples "contains the related jobs" do
  it "returns an array" do
    expect(company["jobs"]).to be_an_instance_of(Array)
  end
  context "each element" do
    include_examples "has the correct job attributes" do
      let(:job) { company["jobs"][0] }
    end
  end
end

RSpec.describe "Companies", type: :request do
  include_context "sign in user"

  before :all do
    3.times { |n| create :company, name: "hello#{n}" }
    3.times { |n| create :company, name: "hi#{n}" }
  end

  describe "GET /index" do
    context "with no params" do
      before :all do
        get companies_path, headers: @auth_headers
      end

      include_examples "response status", 200

      it "returns an array" do
        expect(json_body["data"]).to be_an_instance_of(Array)
      end

      context "each element" do
        include_examples "has the correct company attributes" do
          let(:company) { json_body["data"][0] }
        end
      end
    end

    context "with filter_by_name params" do
      before :all do
        get companies_path, headers: @auth_headers, params: {filter_by_name: "hello"}
      end
      include_examples "response status", 200

      it "returns an array" do
        expect(json_body["data"]).to be_an_instance_of(Array)
      end

      it "filters companies by name" do
        expect(json_body["data"].size).to eq 3
      end
    end

    context "with include_jobs params" do
      before :all do
        @company = Company.first
        create :job, company: @company, user: @user
        get companies_path, headers: @auth_headers, params: {include_jobs: "1"}
      end

      include_examples "response status", 200

      it "returns an array" do
        expect(json_body["data"]).to be_an_instance_of(Array)
      end

      context "each element" do
        include_examples "contains the related jobs" do
          let(:company) { json_body["data"].detect { |c| c["id"] == @company.id } }
        end
      end
    end
  end
end
