require "rails_helper"
require "contexts/authenticate_user"
require "examples/response_examples"

RSpec.describe "UserSkills", type: :request do
  include_context "sign in user"

  describe "GET /index" do
    before(:all) do
      create :user_skill, user: @user
      get user_skills_path, **@auth_headers
    end

    include_examples "response status", 200

    it "should return the list of user_skills" do
      expect(json_body).to eq format_to_response(@user.user_skills)
    end
  end

  describe "GET /show" do
    context "when the user_skill belongs to the user" do
      before(:all) do
        @user_skill = create :user_skill, user: @user
        get user_skill_path(@user_skill), **@auth_headers
      end

      include_examples "response status", 200

      it "should return the user_skill" do
        expect(json_body).to eq format_to_response(@user_skill)
      end
    end

    context "when the user_skill does not belong to the user" do
      before :all do
        get user_skill_path(create(:user_skill)), **@auth_headers
      end
      include_examples "error response"
      include_examples "response status", 404
    end
  end

  describe "POST /create" do
    context "with valid params" do
      before(:all) do
        @original_user_skill_count = UserSkill.count
        post user_skills_path, params: {user_skill: build(:user_skill).attributes}, **@auth_headers
      end

      include_examples "response status", 200

      it "should return the created user_skill" do
        expect(json_body).to eq format_to_response(UserSkill.last)
      end

      it "should create a new user_skill" do
        expect(UserSkill.count).to eq @original_user_skill_count + 1
      end
    end

    context "with invalid params" do
      before(:all) do
        @original_user_skill_count = UserSkill.count
        post user_skills_path, params: {user_skill: {skill_id: ""}}, **@auth_headers
      end

      include_examples "response status", 422

      include_examples "error response"

      it "should not create a new user_skill" do
        expect(UserSkill.count).to eq @original_user_skill_count
      end
    end
  end

  describe "DELETE /destroy" do
    context "when the user_skill exists" do
      before :all do
        @user_skill = create :user_skill, user: @user
        delete user_skill_path(@user_skill), **@auth_headers
      end

      include_examples "response status", 200

      it "should return the deleted user_skill" do
        expect(json_body).to eq format_to_response(@user_skill)
      end
    end

    context "when the user_skill does not exist" do
      before :all do
        delete user_skill_path(build_stubbed(:user_skill)), **@auth_headers
      end
      include_examples "response status", 404
      include_examples "error response"
    end

    context "when the user_skill does not belong to the user" do
      before :all do
        delete user_skill_path(create(:user_skill)), **@auth_headers
      end
      include_examples "error response"
      include_examples "response status", 404
    end
  end
end
