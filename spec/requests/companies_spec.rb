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

  describe "POST /create" do
    context "with valid params" do
      before :all do
        @original_company_count = Company.count
        post companies_path, params: {company: build(:company).attributes}, **@auth_headers
      end

      include_examples "response status", 200

      it "should add a new company" do
        expect(Company.count).to eq @original_company_count + 1
      end

      it "should return the created company" do
        expect(json_body).to eq format_to_response(Company.last)
      end
    end

    context "with invalid params" do
      before :all do
        @original_company_count = Company.count
        post companies_path, params: {company: {name: ""}}, **@auth_headers
      end

      include_examples "response status", 422

      it "should not create a new company" do
        expect(Company.count).to eq @original_company_count
      end

      include_examples "error response"
    end
  end
end
