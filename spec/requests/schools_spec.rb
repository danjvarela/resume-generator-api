require "rails_helper"
require "contexts/authenticate_user"
require "examples/response_examples"

RSpec.describe "Schools", type: :request do
  include_context "sign in user"

  describe "GET /index" do
    before :all do
      3.times { create :school }
      get schools_path, **@auth_headers
    end

    include_examples "response status", 200

    it "should return all schools" do
      expect(json_body).to eq format_to_response(School.all)
    end
  end

  describe "GET /search" do
    before :all do
      3.times { create :school }
      @search_params = {name_cont: "a"}
      get schools_search_path, params: {q: @search_params}, **@auth_headers
    end

    include_examples "response status", 200

    it "should return searched schools" do
      expect(json_body).to eq format_to_response(School.ransack(@search_params).result(distinct: true))
    end
  end
end
