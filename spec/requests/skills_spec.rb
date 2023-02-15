require "rails_helper"
require "contexts/authenticate_user"
require "examples/response_examples"

RSpec.describe "Skills", type: :request do
  include_context "sign in user"

  describe "GET /index" do
    before :all do
      3.times { create :skill }
      get skills_path, **@auth_headers
    end

    include_examples "response status", 200

    it "should return all skills" do
      expect(json_body).to eq format_to_response(Skill.all)
    end
  end

  describe "GET /search" do
    before :all do
      3.times { create :skill }
      @search_params = {name_cont: "co"}
      get skills_search_path, params: {q: @search_params}, **@auth_headers
    end

    include_examples "response status", 200

    it "should return filtered skills" do
      expect(json_body).to eq format_to_response(Skill.ransack(@search_params).result(distinct: true))
    end
  end
end
