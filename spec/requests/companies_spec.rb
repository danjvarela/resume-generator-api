require "rails_helper"
require "contexts/authenticate_user"
require "examples/response_examples"

RSpec.describe "Companies", type: :request do
  include_context "sign in user"

  describe "GET /index" do
    before :all do
      3.times { create :company }
      get companies_path, **@auth_headers
    end

    include_examples "response status", 200

    it "should return all companies" do
      expect(json_body).to eq format_to_response(Company.all)
    end
  end

  describe "GET /search" do
    before :all do
      3.times { create :company }
      @search_params = {name_cont: "a"}
      get companies_search_path, params: {q: @search_params}, **@auth_headers
    end

    include_examples "response status", 200

    it "should return searched companies" do
      expect(json_body).to eq format_to_response(Company.ransack(@search_params).result(distinct: true))
    end
  end
end
