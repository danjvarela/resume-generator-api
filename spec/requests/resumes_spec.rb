require "rails_helper"
require "contexts/authenticate_user"
require "examples/response_examples"

RSpec.describe "Resumes", type: :request do
  include_context "sign in user"

  describe "GET /index" do
    before(:all) do
      create :resume, user: @user
      get resumes_path, **@auth_headers
    end

    include_examples "response status", 200

    it "returns the list of all user resumes" do
      expect(json_body).to eq format_to_response(@user.resumes)
    end
  end

  describe "GET /show" do
    before(:all) do
      @resume = create :resume, user: @user
      get resume_path(@resume), **@auth_headers
    end

    include_examples "response status", 200

    it "should return the resume" do
      expect(json_body).to eq format_to_response(@resume)
    end
  end

  describe "POST /create" do
    context "with valid params" do
      before(:all) do
        @original_resume_count = Resume.count
        post resumes_path, params: {resume: build(:resume).attributes}, **@auth_headers
      end

      include_examples "response status", 200

      it "should return the created resume" do
        expect(json_body).to eq format_to_response(Resume.last)
      end

      it "should create a new resume" do
        expect(Resume.count).to eq @original_resume_count + 1
      end
    end

    context "with invalid params" do
      before(:all) do
        @original_resume_count = Resume.count
        post resumes_path, params: {resume: {title: ""}}, **@auth_headers
      end

      include_examples "response status", 422

      include_examples "error response"

      it "should not create a new resume" do
        expect(Resume.count).to eq @original_resume_count
      end
    end
  end

  describe "PUT/PATCH /update" do
    context "with valid params and when the resume exists" do
      before(:all) do
        @resume = create :resume, user: @user
        @new_resume = build(:resume)
        put resume_path(@resume), params: {resume: @new_resume.attributes}, **@auth_headers
      end

      include_examples "response status", 200

      it "should return the updated resume" do
        expect(json_body).to eq format_to_response(Resume.find(@resume.id))
      end

      it "should update the resume" do
        updated_resume = Resume.find(@resume.id)
        expect(updated_resume.title).to eq @new_resume.title
        expect(updated_resume.headline).to eq @new_resume.headline
        expect(updated_resume.summary).to eq @new_resume.summary
      end
    end

    context "with invalid params" do
      before(:all) do
        @resume = create :resume, user: @user
        put resume_path(@resume), params: {resume: {title: ""}}, **@auth_headers
      end
      include_examples "response status", 422

      include_examples "error response"

      it "does not update the resume" do
        updated_resume = Resume.find(@resume.id)
        expect(updated_resume).to eq @resume
      end
    end

    context "when resume does not exist" do
      before(:all) do
        put resume_path(build_stubbed(:resume)), params: {resume: build(:resume).attributes}, **@auth_headers
      end
      include_examples "response status", 404
      include_examples "error response"
    end
  end

  describe "DELETE /destroy" do
    context "when the resume exists" do
      before :all do
        @resume = create :resume, user: @user
        delete resume_path(@resume), **@auth_headers
      end

      include_examples "response status", 200

      it "should return the deleted resume" do
        expect(json_body).to eq format_to_response(@resume)
      end
    end

    context "when the resume does not exist" do
      before :all do
        delete resume_path(build_stubbed(:resume)), **@auth_headers
      end
      include_examples "response status", 404
      include_examples "error response"
    end
  end
end
