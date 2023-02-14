require "rails_helper"
require "contexts/authenticate_user"

RSpec.describe "Skills", type: :request do
  include_context "sign in user"

  before :all do
    3.times { create :skill }
    @all_skills_response = format_to_response Skill.all
  end

  describe "GET /index" do
    it "should return status 200" do
      get skills_path, **@auth_headers
      expect(status).to eq 200
    end

    it "should return all skills" do
      get skills_path, **@auth_headers
      expect(json_body).to eq @all_skills_response
    end
  end

  describe "GET /search" do
    it "should return status 200" do
      get skill_search_path, params: {q: {name_cont: "co"}}, **@auth_headers
      expect(status).to eq 200
    end

    it "should return filtered skills" do
      get skill_search_path, params: {q: {name_cont: "co"}}, **@auth_headers
      expect(json_body).to eq format_to_response(Skill.ransack(name_cont: "co").result)
    end
  end
end
