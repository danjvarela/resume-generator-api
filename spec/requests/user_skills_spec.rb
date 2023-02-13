require "rails_helper"
require "contexts/authenticate_user"
require "examples/response_examples"
require "examples/user_skill_examples"

RSpec.describe "UserSkills", type: :request do
  include_context "sign in user"

  before :all do
    @user_skill = create :user_skill, user: @user
  end

  describe "GET /index" do
    before(:all) { get user_skills_path, headers: @auth_headers }
    include_examples "response status", 200

    it "returns an array" do
      expect(json_body["data"]).to be_an_instance_of(Array)
    end

    context "each element of the array" do
      it_behaves_like("a user_skill") { let(:user_skill) { json_body["data"][0] } }
    end
  end

  describe "GET /show" do
    before(:all) { get user_skill_path(@user_skill), headers: @auth_headers }
    include_examples "response status", 200
    context "response body" do
      it_behaves_like("a user_skill") { let(:user_skill) { json_body["data"] } }
    end
  end

  describe "POST /create" do
    context "with valid params" do
      before(:all) do
        post user_skills_path, params: {user_skill: build(:user_skill).attributes}, headers: @auth_headers
      end

      include_examples "response status", 200

      context "response body" do
        it_behaves_like("a user_skill") { let(:user_skill) { json_body["data"] } }
      end

      it "creates a new user_skill" do
        expect {
          post user_skills_path, params: {user_skill: build(:user_skill).attributes}, headers: @auth_headers
        }.to change { UserSkill.count }.by(1)
      end
    end

    context "with invalid params" do
      before(:all) do
        post user_skills_path, params: {user_skill: {skill_id: nil}}, headers: @auth_headers
      end
      include_examples "response status", 422

      it_behaves_like "error response"

      it "does not create a new user_skill" do
        expect {
          post user_skills_path, params: {user_skill: {skill_id: nil}}, headers: @auth_headers
        }.not_to change { UserSkill.count }
      end
    end
  end

  describe "DELETE /destroy" do
    context "when the user_skill exists" do
      before :all do
        delete user_skill_path(create(:user_skill)), headers: @auth_headers
      end
      include_examples "response status", 200
      it_behaves_like("a user_skill") { let(:user_skill) { json_body["data"] } }
    end

    context "when the user_skill does not exist" do
      before :all do
        delete user_skill_path(build_stubbed(:user_skill)), headers: @auth_headers
      end
      include_examples "response status", 404
      it_behaves_like "error response"
    end
  end
end
