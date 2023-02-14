require "rails_helper"
require "contexts/authenticate_user"
require "examples/response_examples"
require "examples/resume_examples"

RSpec.describe "Resumes", type: :request do
  include_context "sign in user"

  before :all do
    @resume = create :resume, user: @user
  end

  describe "GET /index" do
    before(:all) { get resumes_path, headers: @auth_headers }
    include_examples "response status", 200

    it "returns an array" do
      expect(json_body["data"]).to be_an_instance_of(Array)
    end

    context "each element of the array" do
      it_behaves_like("a resume") { let(:resume) { json_body["data"][0] } }
    end
  end

  describe "GET /show" do
    before(:all) { get resume_path(@resume), headers: @auth_headers }
    include_examples "response status", 200
    context "response body" do
      it_behaves_like("a resume") { let(:resume) { json_body["data"] } }
    end
  end

  describe "POST /create" do
    context "with valid params" do
      before(:all) do
        post resumes_path, params: {resume: build(:resume).attributes}, headers: @auth_headers
      end
      include_examples "response status", 200

      context "response body" do
        it_behaves_like("a resume") { let(:resume) { json_body["data"] } }
      end

      it "creates a new resume" do
        expect {
          post resumes_path, params: {resume: build(:resume).attributes}, headers: @auth_headers
        }.to change { Resume.count }.by(1)
      end
    end

    context "with invalid params" do
      before(:all) do
        post resumes_path, params: {resume: {title: nil}}, headers: @auth_headers
      end
      include_examples "response status", 422

      it_behaves_like "error response"

      it "does not create a new resume" do
        expect {
          post resumes_path, params: {resume: {title: nil}}, headers: @auth_headers
        }.not_to change { Resume.count }
      end
    end
  end

  describe "PUT/PATCH /update" do
    before(:all) do
      @new_resume = build(:resume)
      @valid_params = {resume: @new_resume.attributes}
      @invalid_params = {resume: {title: nil}}
    end

    context "with valid params and when the resume exists" do
      before(:all) do
        put resume_path(@resume), params: @valid_params, headers: @auth_headers
      end

      include_examples "response status", 200

      context "response body" do
        it_behaves_like("a resume") { let(:resume) { json_body["data"] } }
      end

      it "updates the resume" do
        updated_resume = Resume.find(@resume.id)
        expect(updated_resume.title).to eq @new_resume.title
        expect(updated_resume.headline).to eq @new_resume.headline
        expect(updated_resume.summary).to eq @new_resume.summary
      end
    end

    context "with invalid params" do
      before(:all) do
        put resume_path(@resume), params: @invalid_params, headers: @auth_headers
      end
      include_examples "response status", 422
      it_behaves_like "error response"

      it "does not update the resume" do
        updated_resume = Resume.find(@resume.id)
        expect(updated_resume).to eq @resume
      end
    end

    context "when resume does not exist" do
      before(:all) do
        put resume_path(build_stubbed(:resume)), params: @valid_params, headers: @auth_headers
      end
      include_examples "response status", 404
      it_behaves_like "error response"
    end
  end

  describe "DELETE /destroy" do
    context "when the resume exists" do
      before :all do
        delete resume_path(create(:resume)), headers: @auth_headers
      end
      include_examples "response status", 200
      it_behaves_like("a resume") { let(:resume) { json_body["data"] } }
    end

    context "when the resume does not exist" do
      before :all do
        delete resume_path(build_stubbed(:resume)), headers: @auth_headers
      end
      include_examples "response status", 404
      it_behaves_like "error response"
    end
  end
end
